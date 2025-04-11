package vn.io.echovibe.track.command.controller;

import static vn.io.echovibe.core.constant.Constant.REQUEST_PROCESSED_SUCCESS;

import io.swagger.v3.oas.annotations.Operation;
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
import vn.io.echovibe.track.command.dto.CreateTrackDto;
import vn.io.echovibe.track.command.dto.DeleteTrackDto;
import vn.io.echovibe.track.command.dto.ReleaseTrackDto;
import vn.io.echovibe.track.command.dto.TrackDetailDto;
import vn.io.echovibe.track.command.dto.UpdateTrackDto;
import vn.io.echovibe.track.command.model.CreateTrackCommand;
import vn.io.echovibe.track.command.model.DeleteTrackCommand;
import vn.io.echovibe.track.command.model.ReleaseTrackCommand;
import vn.io.echovibe.track.command.model.UpdateTrackCommand;
import vn.io.echovibe.track.common.model.Tag;
import vn.io.echovibe.track.common.model.TrackDetail;
import vn.io.echovibe.web.dto.BulkDto;
import vn.io.echovibe.web.dto.ResponseDto;

@io.swagger.v3.oas.annotations.tags.Tag(name = "Track")
@RequiredArgsConstructor
@Slf4j
@RequestMapping("v1/tracks")
@RestController
public class TrackCommandController {
  private final CommandDispatcher commandDispatcher;

  @Operation(operationId = "Bulk Create Track")
  @PostMapping("bulk-create")
  public ResponseEntity<ResponseDto<BulkResult>> bulkCreateTrack(
      @Valid @RequestBody BulkDto<CreateTrackDto> bulkCreateTrackDtos) {
    final List<CreateTrackCommand> createTrackCommands =
        bulkCreateTrackDtos.items().stream()
            .map(
                ctd -> {
                  final TrackDetailDto trackDetailDto = ctd.detail();
                  final TrackDetail detail =
                      TrackDetail.builder()
                          .name(trackDetailDto.name())
                          .description(trackDetailDto.description())
                          .thumbnailUrl(trackDetailDto.thumbnailUrl())
                          .build();
                  return CreateTrackCommand.builder()
                      .id(IdentityUtils.generateAggregateId())
                      .detail(detail)
                      .refCode(ctd.refCode())
                      .isPublic(ctd.isPublic())
                      .tags(
                          ctd.tags().stream()
                              .map(tagDto -> new Tag(tagDto.name(), tagDto.isActive()))
                              .collect(Collectors.toList()))
                      .artistIds(ctd.artistIds())
                      .artistRefCodes(ctd.artistRefCodes())
                      .build();
                })
            .collect(Collectors.toList());
    final BulkResult bulkResult = commandDispatcher.send(createTrackCommands);
    return ResponseEntity.ok(ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, bulkResult));
  }

  @Operation(operationId = "Bulk Update Track")
  @PostMapping("bulk-update")
  public ResponseEntity<ResponseDto<BulkResult>> bulkUpdateTrack(
      @Valid @RequestBody BulkDto<UpdateTrackDto> bulkUpdateTrackDtos) {
    final List<UpdateTrackCommand> updateTrackCommands =
        bulkUpdateTrackDtos.items().stream()
            .map(
                utd -> {
                  final TrackDetailDto trackDetailDto = utd.detail();
                  return UpdateTrackCommand.builder()
                      .id(utd.id())
                      .detail(
                          TrackDetail.builder()
                              .name(trackDetailDto.name())
                              .description(trackDetailDto.description())
                              .thumbnailUrl(trackDetailDto.thumbnailUrl())
                              .build())
                      .refCode(utd.refCode())
                      .isPublic(utd.isPublic())
                      .tags(
                          utd.tags().stream()
                              .map(tagDto -> new Tag(tagDto.name(), tagDto.isActive()))
                              .collect(Collectors.toList()))
                      .build();
                })
            .collect(Collectors.toList());
    final BulkResult bulkResult = commandDispatcher.send(updateTrackCommands);
    return ResponseEntity.ok(ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, bulkResult));
  }

  @Operation(operationId = "Bulk Delete Track")
  @PostMapping("bulk-delete")
  public ResponseEntity<ResponseDto<BulkResult>> bulkDeleteTrack(
      @Valid @RequestBody BulkDto<DeleteTrackDto> bulkDeleteTrackDtos) {
    final List<DeleteTrackCommand> deleteTrackCommands =
        bulkDeleteTrackDtos.items().stream()
            .map(dtd -> DeleteTrackCommand.builder().id(dtd.id()).build())
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
            .map(rtd -> ReleaseTrackCommand.builder().id(rtd.id()).build())
            .collect(Collectors.toList());
    final BulkResult bulkResult = commandDispatcher.send(releaseTrackCommands);
    return ResponseEntity.ok(ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, bulkResult));
  }
}
