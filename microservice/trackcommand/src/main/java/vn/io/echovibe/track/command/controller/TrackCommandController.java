package vn.io.echovibe.track.command.controller;

import static vn.io.echovibe.core.constant.Constant.REQUEST_PROCESSED_SUCCESS;

import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.lang.NonNull;
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
import vn.io.echovibe.track.command.dto.TagDto;
import vn.io.echovibe.track.command.dto.TrackArtistDto;
import vn.io.echovibe.track.command.dto.TrackDetailDto;
import vn.io.echovibe.track.command.dto.UpdateTrackDto;
import vn.io.echovibe.track.command.model.CreateTrackCommand;
import vn.io.echovibe.track.command.model.DeleteTrackCommand;
import vn.io.echovibe.track.command.model.ReleaseTrackCommand;
import vn.io.echovibe.track.command.model.UpdateTrackCommand;
import vn.io.echovibe.track.common.model.Tag;
import vn.io.echovibe.track.common.model.TrackArtist;
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
                  final TrackDetail detail = mapToTrackDetail(ctd.detail());
                  final List<TrackArtist> trackArtists = mapToTrackArtists(ctd.trackArtists());
                  final List<Tag> tags = mapToTags(ctd.tags());
                  return CreateTrackCommand.builder()
                      .id(IdentityUtils.generateAggregateId())
                      .detail(detail)
                      .refCode(ctd.refCode())
                      .isPublic(ctd.isPublic())
                      .tags(tags)
                      .trackArtists(trackArtists)
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
                  final TrackDetail detail = mapToTrackDetail(utd.detail());
                  final List<TrackArtist> trackArtists = mapToTrackArtists(utd.trackArtists());
                  final List<Tag> tags = mapToTags(utd.tags());
                  return UpdateTrackCommand.builder()
                      .id(utd.id())
                      .detail(detail)
                      .refCode(utd.refCode())
                      .isPublic(utd.isPublic())
                      .trackArtists(trackArtists)
                      .tags(tags)
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

  private static TrackDetail mapToTrackDetail(@NonNull TrackDetailDto trackDetailDto) {
    return TrackDetail.builder()
        .name(trackDetailDto.name())
        .description(trackDetailDto.description())
        .thumbnailUrl(trackDetailDto.thumbnailUrl())
        .officialReleasedDate(trackDetailDto.officialReleasedDate())
        .build();
  }

  private static TrackArtist mapToTrackArtist(@NonNull TrackArtistDto trackArtistDto) {
    return TrackArtist.builder()
        .artistId(trackArtistDto.artistId())
        .artistRefCode(trackArtistDto.artistRefCode())
        .isMainArtist(trackArtistDto.isMainArtist())
        .isActive(trackArtistDto.isActive())
        .build();
  }

  private static List<TrackArtist> mapToTrackArtists(List<TrackArtistDto> trackArtistDtos) {
    if (Objects.nonNull(trackArtistDtos)) {
      return trackArtistDtos.stream()
          .map(tad -> mapToTrackArtist(tad))
          .collect(Collectors.toList());
    }
    return null;
  }

  private static Tag mapToTag(@NonNull TagDto tagDto) {
    return Tag.builder().name(tagDto.name()).isActive(tagDto.isActive()).build();
  }

  private static List<Tag> mapToTags(List<TagDto> tagDtos) {
    if (Objects.nonNull(tagDtos)) {
      return tagDtos.stream().map(tagDto -> mapToTag(tagDto)).collect(Collectors.toList());
    }
    return null;
  }
}
