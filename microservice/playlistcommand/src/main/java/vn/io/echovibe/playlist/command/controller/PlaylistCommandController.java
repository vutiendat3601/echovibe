package vn.io.echovibe.playlist.command.controller;

import static vn.io.echovibe.core.constant.Constant.REQUEST_PROCESSED_SUCCESS;
import static vn.io.echovibe.playlist.common.constant.PlaylistConstant.PLAYLIST_MADE_VISIBILITY_PUBLIC_SUCCESS;
import static vn.io.echovibe.playlist.common.constant.PlaylistConstant.PLAYLIST_RELEASED_SUCCESS;

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
import vn.io.echovibe.core.dto.BulkDto;
import vn.io.echovibe.core.dto.ResponseDto;
import vn.io.echovibe.core.model.BulkResult;
import vn.io.echovibe.core.utils.IdentityUtils;
import vn.io.echovibe.playlist.command.dto.CreatePlaylistDetailDto;
import vn.io.echovibe.playlist.command.dto.CreatePlaylistDto;
import vn.io.echovibe.playlist.command.dto.DeletePlaylistDto;
import vn.io.echovibe.playlist.command.dto.ReleasePlaylistDto;
import vn.io.echovibe.playlist.command.dto.SetPlaylistVisibilityDto;
import vn.io.echovibe.playlist.command.dto.UpdatePlaylistDetailDto;
import vn.io.echovibe.playlist.command.model.CreatePlaylistCommand;
import vn.io.echovibe.playlist.command.model.DeletePlaylistCommand;
import vn.io.echovibe.playlist.command.model.ReleasePlaylistCommand;
import vn.io.echovibe.playlist.command.model.SetPlaylistVisibilityCommand;
import vn.io.echovibe.playlist.command.model.UpdatePlaylistDetailCommand;
import vn.io.echovibe.playlist.common.model.PlaylistDetail;

@Tag(name = "Playlist")
@RequiredArgsConstructor
@Slf4j
@RequestMapping("v1/playlists")
@RestController
public class PlaylistCommandController {
  private final CommandDispatcher commandDispatcher;

  @Operation(operationId = "Bulk Create Playlist")
  @PostMapping("/bulk-create")
  public ResponseEntity<ResponseDto<BulkResult>> bulkCreatePlaylist(
      @Valid @RequestBody BulkDto<CreatePlaylistDto> bulkCreatePlaylistDtos) {
    final List<CreatePlaylistCommand> createPlaylistCommands =
        bulkCreatePlaylistDtos.items().stream()
            .map(
                cpd -> {
                  final CreatePlaylistDetailDto createPlaylistDetailDto = cpd.detail();
                  return CreatePlaylistCommand.builder()
                      .id(IdentityUtils.generateAggregateId())
                      .detail(
                          PlaylistDetail.builder()
                              .name(createPlaylistDetailDto.name())
                              .description(createPlaylistDetailDto.description())
                              .thumbnailUrl(createPlaylistDetailDto.thumbnailUrl())
                              .refCode(createPlaylistDetailDto.refCode())
                              .build())
                      .build();
                })
            .collect(Collectors.toList());
    final BulkResult bulkResult = commandDispatcher.send(createPlaylistCommands);
    return ResponseEntity.ok(ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, bulkResult));
  }

  @Operation(operationId = "Bulk Update Playlist's detail")
  @PostMapping("bulk-update")
  public ResponseEntity<ResponseDto<BulkResult>> bulkUpdatePlaylistDetail(
      @Valid @RequestBody BulkDto<UpdatePlaylistDetailDto> bulkUpdatePlaylistDetailDtos) {

    final List<UpdatePlaylistDetailCommand> updatePlaylistCommands =
        bulkUpdatePlaylistDetailDtos.items().stream()
            .map(
                upd ->
                    UpdatePlaylistDetailCommand.builder()
                        .id(upd.id())
                        .detail(
                            PlaylistDetail.builder()
                                .name(upd.name())
                                .description(upd.description())
                                .thumbnailUrl(upd.thumbnailUrl())
                                .refCode(upd.refCode())
                                .build())
                        .build())
            .collect(Collectors.toList());
    final BulkResult bulkResult = commandDispatcher.send(updatePlaylistCommands);
    return ResponseEntity.ok(ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, bulkResult));
  }

  @Operation(operationId = "Bulk Delete Playlist")
  @PostMapping("bulk-delete")
  public ResponseEntity<ResponseDto<BulkResult>> bulkDeletePlaylist(
      @Valid @RequestBody BulkDto<DeletePlaylistDto> bulkDeletePlayistDtos) {

    final List<DeletePlaylistCommand> deletePlaylistCommands =
        bulkDeletePlayistDtos.items().stream()
            .map(dad -> DeletePlaylistCommand.builder().id(dad.id()).build())
            .collect(Collectors.toList());
    final BulkResult bulkResult = commandDispatcher.send(deletePlaylistCommands);
    return ResponseEntity.ok(ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, bulkResult));
  }

  @Operation(operationId = "Bulk Release Playlist")
  @PostMapping("bulk-release")
  public ResponseEntity<ResponseDto<BulkResult>> bulkReleasePlaylist(
      @Valid @RequestBody BulkDto<ReleasePlaylistDto> bulkReleasePlaylistDtos) {
    final List<ReleasePlaylistCommand> releasePlaylistCommands =
        bulkReleasePlaylistDtos.items().stream()
            .map(rpd -> ReleasePlaylistCommand.builder().id(rpd.id()).build())
            .collect(Collectors.toList());
    final BulkResult bulkResult = commandDispatcher.send(releasePlaylistCommands);
    return ResponseEntity.ok(ResponseDto.ok(PLAYLIST_RELEASED_SUCCESS, bulkResult));
  }

  @Operation(operationId = "Bulk Set Playlist's visibility")
  @PostMapping("bulk-set-visibility")
  public ResponseEntity<ResponseDto<BulkResult>> bulkSetPlaylistVisibility(
      @Valid @RequestBody BulkDto<SetPlaylistVisibilityDto> bulkSetPlaylistVisibilityDtos) {
    final List<SetPlaylistVisibilityCommand> changePlaylistVisibilityCommands =
        bulkSetPlaylistVisibilityDtos.items().stream()
            .map(
                spv ->
                    SetPlaylistVisibilityCommand.builder()
                        .id(spv.id())
                        .isPublic(spv.isPublic())
                        .build())
            .collect(Collectors.toList());
    final BulkResult bulkResult = commandDispatcher.send(changePlaylistVisibilityCommands);
    return ResponseEntity.ok(ResponseDto.ok(PLAYLIST_MADE_VISIBILITY_PUBLIC_SUCCESS, bulkResult));
  }
}
