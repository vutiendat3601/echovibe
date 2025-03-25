package vn.io.echovibe.artist.command.handler;

import static vn.io.echovibe.artist.common.constant.ArtistBussinessRuleConstant.ARTIST_BR_02;

import java.util.List;
import java.util.Objects;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import vn.io.echovibe.artist.command.domain.ArtistAggregate;
import vn.io.echovibe.artist.command.model.CreateArtistCommand;
import vn.io.echovibe.artist.command.model.DeleteArtistCommand;
import vn.io.echovibe.artist.command.model.ReleaseArtistCommand;
import vn.io.echovibe.artist.command.model.SetArtistVerificationCommand;
import vn.io.echovibe.artist.command.model.UpdateArtistCommand;
import vn.io.echovibe.artist.common.dto.ArtistDto;
import vn.io.echovibe.client.rest.ArtistQueryClient;
import vn.io.echovibe.core.event.EventSourcingHandler;
import vn.io.echovibe.core.exception.AggregateNotFoundException;
import vn.io.echovibe.core.exception.BusinessRuleViolationException;
import vn.io.echovibe.web.dto.ResponseDto;

@RequiredArgsConstructor
@Service
public class ArtistCommandHandler implements CommandHandler {
  private final EventSourcingHandler<ArtistAggregate> eventSourcingHandler;
  private final ArtistQueryClient artistQueryClient;

  @Override
  public void handle(@NonNull CreateArtistCommand createArtistCommand) {
    final String refCode = createArtistCommand.getRefCode();
    if (Objects.nonNull(refCode)) {
      final ResponseDto<List<ArtistDto>> respDto =
          artistQueryClient.getArtistByRefCodes(List.of(refCode)).getBody();
      if (Objects.isNull(respDto) || !CollectionUtils.isEmpty(respDto.data())) {
        throw new BusinessRuleViolationException(ARTIST_BR_02);
      }
    }
    final ArtistAggregate artistAggregate = new ArtistAggregate(createArtistCommand);
    eventSourcingHandler.save(artistAggregate);
  }

  @Override
  public void handle(@NonNull UpdateArtistCommand updateArtistCommand) {
    final ArtistAggregate artistAggregate = findArtistAggregateById(updateArtistCommand.getId());
    artistAggregate.update(updateArtistCommand);
    eventSourcingHandler.save(artistAggregate);
  }

  @Override
  public void handle(@NonNull ReleaseArtistCommand releaseArtistCommand) {
    final ArtistAggregate artistAggregate = findArtistAggregateById(releaseArtistCommand.getId());
    artistAggregate.release();
    eventSourcingHandler.save(artistAggregate);
  }

  @Override
  public void handle(@NonNull DeleteArtistCommand deleteArtistCommand) {
    final ArtistAggregate artistAggregate = findArtistAggregateById(deleteArtistCommand.getId());
    artistAggregate.delete();
    eventSourcingHandler.save(artistAggregate);
  }

  @Override
  public void handle(@NonNull SetArtistVerificationCommand setArtistVerificationCommand) {
    final ArtistAggregate artistAggregate =
        findArtistAggregateById(setArtistVerificationCommand.getId());
    artistAggregate.setVerified(setArtistVerificationCommand.getIsPublic());
    eventSourcingHandler.save(artistAggregate);
  }

  private ArtistAggregate findArtistAggregateById(@NonNull String id) {
    final ArtistAggregate artistAggregate = eventSourcingHandler.findById(id);
    final boolean isActive = Optional.ofNullable(artistAggregate.getIsActive()).orElse(true);
    if (!isActive) {
      throw new AggregateNotFoundException("Artist not found: aggregateId=%s".formatted(id));
    }
    return artistAggregate;
  }
}
