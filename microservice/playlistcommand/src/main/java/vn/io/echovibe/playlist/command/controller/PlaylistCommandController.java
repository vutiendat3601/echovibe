package vn.io.echovibe.playlist.command.controller;

import static vn.io.echovibe.core.constant.Constant.REQUEST_PROCESSED_SUCCESS;
import static vn.io.echovibe.core.utils.IdentityUtils.AGGREGATE_ID_LENGTH;
import static vn.io.echovibe.core.utils.IdentityUtils.AGGREGATE_ID_REGEX;
import static vn.io.echovibe.playlist.common.constant.PlaylistConstant.PLAYLIST_MADE_VISIBILITY_PRIVATE_SUCCESS;
import static vn.io.echovibe.playlist.common.constant.PlaylistConstant.PLAYLIST_MADE_VISIBILITY_PUBLIC_SUCCESS;
import static vn.io.echovibe.playlist.common.constant.PlaylistConstant.PLAYLIST_RELEASED_SUCCESS;

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
import vn.io.echovibe.playlist.command.dto.CreatePlaylistDto;
import vn.io.echovibe.playlist.command.dto.DeletePlaylistDto;
import vn.io.echovibe.playlist.command.dto.UpdatePlaylistDto;
import vn.io.echovibe.playlist.command.model.ChangePlaylistVisibilityCommand;
import vn.io.echovibe.playlist.command.model.CreatePlaylistCommand;
import vn.io.echovibe.playlist.command.model.DeletePlaylistCommand;
import vn.io.echovibe.playlist.command.model.ReleasePlaylistCommand;
import vn.io.echovibe.playlist.command.model.UpdatePlaylistCommand;

@Tag(name = "Playlist")
@RequiredArgsConstructor
@Slf4j
@RequestMapping("v1/playlists")
@RestController
public class PlaylistCommandController {
  private final CommandDispatcher commandDispatcher;

  @Operation(operationId = "Bulk Create Playlist")
  @PostMapping("/bulk-create")
  public ResponseEntity<ResponseDto<BulkResult>> createPlaylist(
      @Valid @RequestBody BulkDto<CreatePlaylistDto> bulkCreateDto) {
    final List<CreatePlaylistCommand> createPlaylistCommands =
        bulkCreateDto.items().stream()
            .map(
                ctd ->
                    CreatePlaylistCommand.builder()
                        .id(IdentityUtils.generateAggregateId())
                        .name(ctd.name())
                        .description(ctd.description())
                        .thumbnailUrl(ctd.thumbnailUrl())
                        .artistIds(ctd.artistIds())
                        .build())
            .collect(Collectors.toList());
    final BulkResult bulkResult = commandDispatcher.send(createPlaylistCommands);
    return ResponseEntity.ok(ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, bulkResult));
  }

  @Operation(operationId = "Bulk Update Playlist")
  @PostMapping("bulk-update")
  public ResponseEntity<ResponseDto<BulkResult>> updatePlaylist(
      @Valid @RequestBody BulkDto<UpdatePlaylistDto> bulkUpdateDto) {
    final List<UpdatePlaylistCommand> updatePlaylistCommands =
        bulkUpdateDto.items().stream()
            .map(
                upd ->
                    UpdatePlaylistCommand.builder()
                        .id(upd.id())
                        .name(upd.name())
                        .thumbnailUrl(upd.thumbnailUrl())
                        .build())
            .collect(Collectors.toList());
    final BulkResult bulkResult = commandDispatcher.send(updatePlaylistCommands);
    return ResponseEntity.ok(ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, bulkResult));
  }

  @Operation(operationId = "Bulk Delete Playlist")
  @PostMapping("bulk-delete")
  public ResponseEntity<ResponseDto<BulkResult>> deletePlaylist(
      @Valid @RequestBody BulkDto<DeletePlaylistDto> bulkDeleteDto) {
    final List<DeletePlaylistCommand> deletePlaylistCommands =
        bulkDeleteDto.items().stream()
            .map(dad -> DeletePlaylistCommand.builder().id(dad.id()).build())
            .collect(Collectors.toList());
    final BulkResult bulkResult = commandDispatcher.send(deletePlaylistCommands);
    return ResponseEntity.ok(ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, bulkResult));
  }

  @Operation(operationId = "Release Playlist")
  @PostMapping("{id}/release")
  public ResponseEntity<ResponseDto<EmptyObjectDto>> releasePlaylist(
      @Valid
          @Pattern(
              regexp = AGGREGATE_ID_REGEX,
              message = "Playlist ID must contain [A-Z, a-z, 0-9] only.")
          @Length(
              min = AGGREGATE_ID_LENGTH,
              max = AGGREGATE_ID_LENGTH,
              message = "Playlist ID must contain " + AGGREGATE_ID_LENGTH + " characters only.")
          @PathVariable
          String id) {
    final ReleasePlaylistCommand releasePlaylistCommand =
        ReleasePlaylistCommand.builder().id(id).build();
    commandDispatcher.send(releasePlaylistCommand);
    return ResponseEntity.ok(ResponseDto.ok(PLAYLIST_RELEASED_SUCCESS));
  }

  @Operation(operationId = "Make Playlist visibility public")
  @PostMapping("{id}/visibility/make-public")
  public ResponseEntity<ResponseDto<EmptyObjectDto>> makePlaylistVisibilityPublic(
      @Valid
          @Pattern(
              regexp = AGGREGATE_ID_REGEX,
              message = "Playlist ID must contain [A-Z, a-z, 0-9] only.")
          @Length(
              min = AGGREGATE_ID_LENGTH,
              max = AGGREGATE_ID_LENGTH,
              message = "Playlist ID must contain " + AGGREGATE_ID_LENGTH + " characters only.")
          @PathVariable
          String id) {
    final ChangePlaylistVisibilityCommand changePlaylistVisibilityCommand =
        ChangePlaylistVisibilityCommand.builder().id(id).isPublic(true).build();
    commandDispatcher.send(changePlaylistVisibilityCommand);
    return ResponseEntity.ok(ResponseDto.ok(PLAYLIST_MADE_VISIBILITY_PUBLIC_SUCCESS));
  }

  @Operation(operationId = "Make Playlist's visibility private")
  @PostMapping("{id}/visibility/make-private")
  public ResponseEntity<ResponseDto<EmptyObjectDto>> makePlaylistVisibilityPrivate(
      @Valid
          @Pattern(
              regexp = AGGREGATE_ID_REGEX,
              message = "Playlist ID must contain [A-Z, a-z, 0-9] only.")
          @Length(
              min = AGGREGATE_ID_LENGTH,
              max = AGGREGATE_ID_LENGTH,
              message = "Playlist ID must contain " + AGGREGATE_ID_LENGTH + " characters only.")
          @PathVariable
          String id) {
    final ChangePlaylistVisibilityCommand changePlaylistVisibilityCommand =
        ChangePlaylistVisibilityCommand.builder().id(id).isPublic(false).build();
    commandDispatcher.send(changePlaylistVisibilityCommand);
    return ResponseEntity.ok(ResponseDto.ok(PLAYLIST_MADE_VISIBILITY_PRIVATE_SUCCESS));
  }
}
