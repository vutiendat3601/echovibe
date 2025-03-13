package vn.io.echovibe.track.command.controller;

import static vn.io.echovibe.core.constant.Constant.REQUEST_PROCESSED_SUCCESS;
import static vn.io.echovibe.core.utils.IdentityUtils.AGGREGATE_ID_LENGTH;
import static vn.io.echovibe.core.utils.IdentityUtils.AGGREGATE_ID_REGEX;
import static vn.io.echovibe.track.common.constant.TrackConstant.TRACK_MADE_VISIBILITY_PRIVATE_SUCCESS;
import static vn.io.echovibe.track.common.constant.TrackConstant.TRACK_MADE_VISIBILITY_PUBLIC_SUCCESS;
import static vn.io.echovibe.track.common.constant.TrackConstant.TRACK_RELEASED_SUCCESS;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Pattern;
import java.util.List;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.validator.constraints.Length;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import vn.io.echovibe.core.command.CommandDispatcher;
import vn.io.echovibe.core.dto.BulkDto;
import vn.io.echovibe.core.dto.EmptyObjectDto;
import vn.io.echovibe.core.dto.ResponseDto;
import vn.io.echovibe.core.model.BulkResult;
import vn.io.echovibe.core.utils.IdentityUtils;
import vn.io.echovibe.track.command.dto.CreateTrackDto;
import vn.io.echovibe.track.command.dto.DeleteTrackDto;
import vn.io.echovibe.track.command.dto.UpdateTrackDto;
import vn.io.echovibe.track.command.model.ChangeTrackVisibilityCommand;
import vn.io.echovibe.track.command.model.CreateTrackCommand;
import vn.io.echovibe.track.command.model.DeleteTrackCommand;
import vn.io.echovibe.track.command.model.ReleaseTrackCommand;
import vn.io.echovibe.track.command.model.UpdateTrackCommand;

@Tag(name = "Track")
@RequiredArgsConstructor
@Slf4j
@RequestMapping("v1/tracks")
@RestController
public class TrackCommandController {
  private final CommandDispatcher commandDispatcher;

  @Operation(operationId = "Bulk Create Track")
  @PostMapping("/bulk-create")
  public ResponseEntity<ResponseDto<BulkResult>> createTrack(
      @Valid @RequestBody BulkDto<CreateTrackDto> bulkCreateDto) {
    final List<CreateTrackCommand> createTrackCommands =
        bulkCreateDto.items().stream()
            .map(
                cad ->
                    CreateTrackCommand.builder()
                        .id(IdentityUtils.generateAggregateId())
                        .name(cad.name())
                        .biography(cad.biography())
                        .description(cad.description())
                        .thumbnailUrl(cad.thumbnailUrl())
                        .backgroundUrl(cad.backgroundUrl())
                        .build())
            .collect(Collectors.toList());
    final BulkResult bulkResult = commandDispatcher.send(createTrackCommands);
    return ResponseEntity.ok(ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, bulkResult));
  }

  @Operation(operationId = "Bulk Update Track")
  @PostMapping("bulk-update")
  public ResponseEntity<ResponseDto<BulkResult>> updateTrack(
      @Valid @RequestBody BulkDto<UpdateTrackDto> bulkUpdateDto) {
    final List<UpdateTrackCommand> updateTrackCommands =
        bulkUpdateDto.items().stream()
            .map(
                uad ->
                    UpdateTrackCommand.builder()
                        .id(uad.id())
                        .name(uad.name())
                        .thumbnailUrl(uad.thumbnailUrl())
                        .build())
            .collect(Collectors.toList());
    final BulkResult bulkResult = commandDispatcher.send(updateTrackCommands);
    return ResponseEntity.ok(ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, bulkResult));
  }

  @Operation(operationId = "Bulk Delete Track")
  @PostMapping("bulk-delete")
  public ResponseEntity<ResponseDto<BulkResult>> deleteTrack(
      @Valid @RequestBody BulkDto<DeleteTrackDto> bulkDeleteDto) {
    final List<DeleteTrackCommand> deleteTrackCommands =
        bulkDeleteDto.items().stream()
            .map(dad -> DeleteTrackCommand.builder().id(dad.id()).build())
            .collect(Collectors.toList());
    final BulkResult bulkResult = commandDispatcher.send(deleteTrackCommands);
    return ResponseEntity.ok(ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, bulkResult));
  }

  @Operation(operationId = "Release Track")
  @PostMapping("{id}/release")
  public ResponseEntity<ResponseDto<EmptyObjectDto>> releaseTrack(
      @Valid
          @Pattern(
              regexp = AGGREGATE_ID_REGEX,
              message = "Track ID must contain [A-Z, a-z, 0-9] only.")
          @Length(
              min = AGGREGATE_ID_LENGTH,
              max = AGGREGATE_ID_LENGTH,
              message = "Track ID must contain " + AGGREGATE_ID_LENGTH + " characters only.")
          @PathVariable
          String id) {
    final ReleaseTrackCommand releaseTrackCommand = ReleaseTrackCommand.builder().id(id).build();
    commandDispatcher.send(releaseTrackCommand);
    return ResponseEntity.ok(ResponseDto.ok(TRACK_RELEASED_SUCCESS));
  }

  @Operation(operationId = "Make Track visibility public")
  @PostMapping("{id}/visibility/make-public")
  public ResponseEntity<ResponseDto<EmptyObjectDto>> makeTrackVisibilityPublic(
      @Valid
          @Pattern(
              regexp = AGGREGATE_ID_REGEX,
              message = "Track ID must contain [A-Z, a-z, 0-9] only.")
          @Length(
              min = AGGREGATE_ID_LENGTH,
              max = AGGREGATE_ID_LENGTH,
              message = "Track ID must contain " + AGGREGATE_ID_LENGTH + " characters only.")
          @PathVariable
          String id) {
    final ChangeTrackVisibilityCommand changeTrackVisibilityCommand =
        ChangeTrackVisibilityCommand.builder().id(id).isPublic(true).build();
    commandDispatcher.send(changeTrackVisibilityCommand);
    return ResponseEntity.ok(ResponseDto.ok(TRACK_MADE_VISIBILITY_PUBLIC_SUCCESS));
  }

  @Operation(operationId = "Make Track's visibility private")
  @PostMapping("{id}/visibility/make-private")
  public ResponseEntity<ResponseDto<EmptyObjectDto>> makeTrackVisibilityPrivate(
      @Valid
          @Pattern(
              regexp = AGGREGATE_ID_REGEX,
              message = "Track ID must contain [A-Z, a-z, 0-9] only.")
          @Length(
              min = AGGREGATE_ID_LENGTH,
              max = AGGREGATE_ID_LENGTH,
              message = "Track ID must contain " + AGGREGATE_ID_LENGTH + " characters only.")
          @PathVariable
          String id) {
    final ChangeTrackVisibilityCommand changeTrackVisibilityCommand =
        ChangeTrackVisibilityCommand.builder().id(id).isPublic(false).build();
    commandDispatcher.send(changeTrackVisibilityCommand);
    return ResponseEntity.ok(ResponseDto.ok(TRACK_MADE_VISIBILITY_PRIVATE_SUCCESS));
  }
}
