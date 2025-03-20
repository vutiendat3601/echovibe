package vn.io.echovibe.track.command.controller;

import static vn.io.echovibe.core.constant.Constant.REQUEST_PROCESSED_SUCCESS;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import java.util.List;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import vn.io.echovibe.core.command.CommandDispatcher;
import vn.io.echovibe.core.model.BulkResult;
import vn.io.echovibe.core.util.IdentityUtils;
import vn.io.echovibe.track.command.dto.CreateTrackDetailDto;
import vn.io.echovibe.track.command.dto.CreateTrackDto;
import vn.io.echovibe.track.command.dto.DeleteTrackDto;
import vn.io.echovibe.track.command.dto.ReleaseTrackDto;
import vn.io.echovibe.track.command.dto.SetTrackVisibilityDto;
import vn.io.echovibe.track.command.dto.UpdateTrackDetailDto;
import vn.io.echovibe.track.command.model.CreateTrackCommand;
import vn.io.echovibe.track.command.model.DeleteTrackCommand;
import vn.io.echovibe.track.command.model.ReleaseTrackCommand;
import vn.io.echovibe.track.command.model.SetTrackVisibilityCommand;
import vn.io.echovibe.track.command.model.UpdateTrackDetailCommand;
import vn.io.echovibe.track.common.model.TrackDetail;
import vn.io.echovibe.web.dto.BulkDto;
import vn.io.echovibe.web.dto.ResponseDto;

@Tag(name = "Track")
@RequiredArgsConstructor
@Slf4j
@RequestMapping("v1/tracks")
@RestController
public class TrackCommandController {
  private final CommandDispatcher commandDispatcher;

  @Operation(operationId = "Bulk Create Track")
  @PostMapping("/bulk-create")
  public ResponseEntity<ResponseDto<BulkResult>> bulkCreateTrack(
      @Valid @RequestBody BulkDto<CreateTrackDto> bulkCreateTrackDtos) {
    final List<CreateTrackCommand> createTrackCommands =
        bulkCreateTrackDtos.items().stream()
            .map(
                ctd -> {
                  final CreateTrackDetailDto createTrackDetailDto = ctd.detail();
                  return CreateTrackCommand.builder()
                      .id(IdentityUtils.generateAggregateId())
                      .detail(
                          TrackDetail.builder()
                              .name(createTrackDetailDto.name())
                              .description(createTrackDetailDto.description())
                              .thumbnailUrl(createTrackDetailDto.thumbnailUrl())
                              .refCode(createTrackDetailDto.refCode())
                              .build())
                      .artistIds(ctd.artistIds())
                      .build();
                })
            .collect(Collectors.toList());
    final BulkResult bulkResult = commandDispatcher.send(createTrackCommands);
    return ResponseEntity.ok(ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, bulkResult));
  }

  @Operation(operationId = "Bulk Update Track's detail")
  @PostMapping("bulk-update")
  public ResponseEntity<ResponseDto<BulkResult>> bulkUpdateTrackDetail(
      @Valid @RequestBody BulkDto<UpdateTrackDetailDto> bulkUpdateTrackDetailDtos) {
    final List<UpdateTrackDetailCommand> updateTrackCommands =
        bulkUpdateTrackDetailDtos.items().stream()
            .map(
                upd ->
                    UpdateTrackDetailCommand.builder()
                        .id(upd.id())
                        .detail(
                            TrackDetail.builder()
                                .name(upd.name())
                                .description(upd.description())
                                .thumbnailUrl(upd.thumbnailUrl())
                                .refCode(upd.refCode())
                                .build())
                        .build())
            .collect(Collectors.toList());
    final BulkResult bulkResult = commandDispatcher.send(updateTrackCommands);
    return ResponseEntity.ok(ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, bulkResult));
  }

  @Operation(operationId = "Bulk Delete Track")
  @PostMapping("bulk-delete")
  public ResponseEntity<ResponseDto<BulkResult>> bulkDeleteTrack(
      @Valid @RequestBody BulkDto<DeleteTrackDto> bulkDeletePlayistDtos) {

    final List<DeleteTrackCommand> deleteTrackCommands =
        bulkDeletePlayistDtos.items().stream()
            .map(dad -> DeleteTrackCommand.builder().id(dad.id()).build())
            .collect(Collectors.toList());
    final BulkResult bulkResult = commandDispatcher.send(deleteTrackCommands);
    return ResponseEntity.ok(ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, bulkResult));
  }

  @Operation(operationId = "Bulk Release Track")
  @PostMapping("bulk-release")
  public ResponseEntity<ResponseDto<BulkResult>> releaseTrack(
      @Valid @RequestBody BulkDto<ReleaseTrackDto> bulkReleaseTrackDtos) {
    final List<ReleaseTrackCommand> releaseTrackCommands =
        bulkReleaseTrackDtos.items().stream()
            .map(rpd -> ReleaseTrackCommand.builder().id(rpd.id()).build())
            .collect(Collectors.toList());
    final BulkResult bulkResult = commandDispatcher.send(releaseTrackCommands);
    return ResponseEntity.ok(ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, bulkResult));
  }

  @Operation(operationId = "Bulk Set Track's visibility")
  @PostMapping("bulk-set-visibility")
  public ResponseEntity<ResponseDto<BulkResult>> bulkSetTrackVisibility(
      @Valid @RequestBody BulkDto<SetTrackVisibilityDto> bulkSetTrackVisibilityDtos) {
    final List<SetTrackVisibilityCommand> changeTrackVisibilityCommands =
        bulkSetTrackVisibilityDtos.items().stream()
            .map(
                spv ->
                    SetTrackVisibilityCommand.builder()
                        .id(spv.id())
                        .isPublic(spv.isPublic())
                        .build())
            .collect(Collectors.toList());
    final BulkResult bulkResult = commandDispatcher.send(changeTrackVisibilityCommands);
    return ResponseEntity.ok(ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, bulkResult));
  }
}
