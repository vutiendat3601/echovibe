package vn.io.echovibe.track.command.handler;

import static vn.io.echovibe.track.common.constant.TrackBusinessRuleConstant.TRACK_BR_02;

import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import vn.io.echovibe.artist.common.dto.ArtistDto;
import vn.io.echovibe.client.rest.ArtistQueryClient;
import vn.io.echovibe.client.rest.TrackQueryClient;
import vn.io.echovibe.core.event.EventSourcingHandler;
import vn.io.echovibe.core.exception.AggregateNotFoundException;
import vn.io.echovibe.core.exception.BusinessRuleViolationException;
import vn.io.echovibe.track.command.domain.TrackAggregate;
import vn.io.echovibe.track.command.model.CreateTrackCommand;
import vn.io.echovibe.track.command.model.DeleteTrackCommand;
import vn.io.echovibe.track.command.model.ReleaseTrackCommand;
import vn.io.echovibe.track.command.model.UpdateTrackCommand;
import vn.io.echovibe.track.common.dto.TrackDto;
import vn.io.echovibe.track.common.model.TrackArtist;
import vn.io.echovibe.web.dto.ResponseDto;

@RequiredArgsConstructor
@Service
public class TrackCommandHandler implements CommandHandler {
  private final EventSourcingHandler<TrackAggregate> eventSourcingHandler;
  private final ArtistQueryClient artistQueryClient;
  private final TrackQueryClient trackQueryClient;

  @Override
  public void handle(@NonNull CreateTrackCommand createTrackCommand) {
    validateRefCode(createTrackCommand.getRefCode());
    processTrackArtists(createTrackCommand.getTrackArtists());
    final TrackAggregate trackAggregate = new TrackAggregate(createTrackCommand);
    eventSourcingHandler.save(trackAggregate);
  }

  @Override
  public void handle(@NonNull UpdateTrackCommand updateTrackCommand) {
    processTrackArtists(updateTrackCommand.getTrackArtists());
    final TrackAggregate trackAggregate = findTrackAggregateById(updateTrackCommand.getId());
    trackAggregate.update(updateTrackCommand);
    eventSourcingHandler.save(trackAggregate);
  }

  @Override
  public void handle(@NonNull ReleaseTrackCommand releaseTrackCommand) {
    final TrackAggregate trackAggregate = findTrackAggregateById(releaseTrackCommand.getId());
    trackAggregate.release();
    eventSourcingHandler.save(trackAggregate);
  }

  @Override
  public void handle(@NonNull DeleteTrackCommand deleteTrackCommand) {
    final TrackAggregate trackAggregate = findTrackAggregateById(deleteTrackCommand.getId());
    trackAggregate.delete();
    eventSourcingHandler.save(trackAggregate);
  }

  private TrackAggregate findTrackAggregateById(@NonNull String id) {
    final TrackAggregate trackAggregate = eventSourcingHandler.findById(id);
    final boolean isActive = Optional.ofNullable(trackAggregate.getIsActive()).orElse(true);
    if (!isActive) {
      throw new AggregateNotFoundException("Artist not found: aggregateId=%s".formatted(id));
    }
    return trackAggregate;
  }

  private void processTrackArtists(@NonNull List<TrackArtist> trackArtists) {
    final List<String> artistIds =
        trackArtists.stream()
            .map(TrackArtist::getArtistId)
            .filter(Objects::nonNull)
            .collect(Collectors.toList());

    if (!CollectionUtils.isEmpty(artistIds)) {
      final ResponseDto<List<ArtistDto>> respDto =
          artistQueryClient.getArtistByIds(String.join(",", artistIds)).getBody();
      if (Objects.isNull(respDto) || CollectionUtils.isEmpty(respDto.data())) {
        throw new RuntimeException("Internal Server Error");
      } else {
        final List<ArtistDto> artistDtos = respDto.data();
        final Map<String, ArtistDto> artistDtoMap =
            artistDtos.stream()
                .filter(ad -> Objects.nonNull(ad))
                .collect(Collectors.toMap(ArtistDto::id, artistDto -> artistDto));
        final List<String> notFoundArtistIds =
            artistIds.stream()
                .filter(artistId -> !artistDtoMap.containsKey(artistId))
                .collect(Collectors.toList());
        if (!CollectionUtils.isEmpty(notFoundArtistIds)) {
          throw new AggregateNotFoundException(
              "Artist not found: artistIds=%s".formatted(notFoundArtistIds));
        }
      }
    }

    // Validate Artist by refCodes
    final List<String> artistRefCodes =
        trackArtists.stream()
            .map(TrackArtist::getArtistRefCode)
            .filter(Objects::nonNull)
            .collect(Collectors.toList());
    if (!CollectionUtils.isEmpty(artistRefCodes)) {
      final ResponseDto<List<ArtistDto>> respDto =
          artistQueryClient.getArtistByRefCodes(String.join(",", artistRefCodes)).getBody();
      if (Objects.isNull(respDto) || CollectionUtils.isEmpty(respDto.data())) {
        throw new RuntimeException("Internal Server Error");
      } else {
        final List<ArtistDto> artistDtos = respDto.data();
        final Map<String, ArtistDto> artistDtoMap =
            artistDtos.stream()
                .filter(ad -> Objects.nonNull(ad))
                .collect(Collectors.toMap(ArtistDto::refCode, artistDto -> artistDto));
        final List<String> notFoundArtistRefCodes =
            artistRefCodes.stream()
                .filter(artistRefCode -> !artistDtoMap.containsKey(artistRefCode))
                .collect(Collectors.toList());
        if (!CollectionUtils.isEmpty(notFoundArtistRefCodes)) {
          throw new AggregateNotFoundException(
              "Artist not found: artistRefCodes=%s".formatted(notFoundArtistRefCodes));
        } else {
          final Map<String, TrackArtist> trackArtistsMap =
              trackArtists.stream()
                  .collect(Collectors.toMap(TrackArtist::getArtistRefCode, ta -> ta));
          artistDtos.stream()
              .filter(artistDto -> !artistIds.contains(artistDto.id()))
              .forEach(
                  artistDto ->
                      trackArtistsMap.get(artistDto.refCode()).setArtistId(artistDto.id()));
        }
      }
    }
  }

  private void validateRefCode(@NonNull String refCode) {
    if (Objects.nonNull(refCode)) {
      final ResponseDto<List<TrackDto>> respDto =
          trackQueryClient.getTrackByRefCodes(refCode).getBody();
      if (Objects.isNull(respDto) || CollectionUtils.isEmpty(respDto.data())) {
        throw new RuntimeException("Internal Server Error");
      } else if (Objects.nonNull(respDto.data().get(0))) {
        throw new BusinessRuleViolationException(TRACK_BR_02);
      }
    }
  }
}
