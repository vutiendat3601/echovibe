package vn.io.echovibe.track.command.handler;

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
import vn.io.echovibe.core.event.EventSourcingHandler;
import vn.io.echovibe.core.exception.AggregateNotFoundException;
import vn.io.echovibe.track.command.domain.TrackAggregate;
import vn.io.echovibe.track.command.model.CreateTrackCommand;
import vn.io.echovibe.track.command.model.DeleteTrackCommand;
import vn.io.echovibe.track.command.model.ReleaseTrackCommand;
import vn.io.echovibe.track.command.model.UpdateTrackCommand;
import vn.io.echovibe.web.dto.ResponseDto;

@RequiredArgsConstructor
@Service
public class TrackCommandHandler implements CommandHandler {
  private final EventSourcingHandler<TrackAggregate> eventSourcingHandler;
  private final ArtistQueryClient artistQueryClient;

  @Override
  public void handle(@NonNull CreateTrackCommand createTrackCommand) {
    final List<String> artistIds = createTrackCommand.getArtistIds();

    // Validate Artist by ids
    if (Objects.nonNull(artistIds) && !CollectionUtils.isEmpty(artistIds)) {
      final ResponseDto<List<ArtistDto>> respDto =
          artistQueryClient.getArtistByIds(artistIds).getBody();
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
    final List<String> artistRefCodes = createTrackCommand.getArtistRefCodes();
    if (Objects.nonNull(artistRefCodes) && !CollectionUtils.isEmpty(artistRefCodes)) {
      final ResponseDto<List<ArtistDto>> respDto =
          artistQueryClient.getArtistByRefCodes(artistRefCodes).getBody();
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
          artistDtos.stream().map(ArtistDto::id).forEach(artistId -> artistIds.add(artistId));
        }
      }
    }
    final TrackAggregate trackAggregate = new TrackAggregate(createTrackCommand);
    eventSourcingHandler.save(trackAggregate);
  }

  @Override
  public void handle(@NonNull UpdateTrackCommand updateTrackCommand) {
    final TrackAggregate trackAggregate = findTrackAggregateById(updateTrackCommand.getId());
    trackAggregate.update(updateTrackCommand);
    eventSourcingHandler.save(trackAggregate);
  }

  @Override
  public void handle(@NonNull ReleaseTrackCommand publishArtistCommand) {
    final TrackAggregate trackAggregate = findTrackAggregateById(publishArtistCommand.getId());
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
}
