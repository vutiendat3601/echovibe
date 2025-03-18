package vn.io.echovibe.artist.command.controller;

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
import vn.io.echovibe.artist.command.dto.CreateArtistDto;
import vn.io.echovibe.artist.command.dto.CreateArtistProfileDto;
import vn.io.echovibe.artist.command.dto.DeleteArtistDto;
import vn.io.echovibe.artist.command.dto.ReleaseArtistDto;
import vn.io.echovibe.artist.command.dto.SetArtistVisibilityDto;
import vn.io.echovibe.artist.command.dto.UpdateArtistProfileDto;
import vn.io.echovibe.artist.command.model.CreateArtistCommand;
import vn.io.echovibe.artist.command.model.DeleteArtistCommand;
import vn.io.echovibe.artist.command.model.ReleaseArtistCommand;
import vn.io.echovibe.artist.command.model.SetArtistVisibilityCommand;
import vn.io.echovibe.artist.command.model.UpdateArtistProfileCommand;
import vn.io.echovibe.artist.common.model.ArtistProfile;
import vn.io.echovibe.core.command.CommandDispatcher;
import vn.io.echovibe.core.dto.BulkDto;
import vn.io.echovibe.core.dto.ResponseDto;
import vn.io.echovibe.core.model.BulkResult;
import vn.io.echovibe.core.utils.IdentityUtils;

@Tag(name = "Artist")
@RequiredArgsConstructor
@Slf4j
@RequestMapping("v1/artists")
@RestController
public class ArtistCommandController {
  private final CommandDispatcher commandDispatcher;

  @Operation(operationId = "Bulk Create Artist")
  @PostMapping("bulk-create")
  public ResponseEntity<ResponseDto<BulkResult>> bulkCreateArtist(
      @Valid @RequestBody BulkDto<CreateArtistDto> bulkCreateArtistDtos) {
    final List<CreateArtistCommand> createArtistCommands =
        bulkCreateArtistDtos.items().stream()
            .map(
                cad -> {
                  final CreateArtistProfileDto createArtistProfileDto = cad.profile();
                  return CreateArtistCommand.builder()
                      .id(IdentityUtils.generateAggregateId())
                      .profile(
                          ArtistProfile.builder()
                              .name(createArtistProfileDto.name())
                              .biography(createArtistProfileDto.biography())
                              .description(createArtistProfileDto.description())
                              .thumbnailUrl(createArtistProfileDto.thumbnailUrl())
                              .backgroundUrl(createArtistProfileDto.backgroundUrl())
                              .refCode(createArtistProfileDto.refCode())
                              .build())
                      .build();
                })
            .collect(Collectors.toList());
    final BulkResult bulkResult = commandDispatcher.send(createArtistCommands);
    return ResponseEntity.ok(ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, bulkResult));
  }

  @Operation(operationId = "Bulk Update Artist's profile")
  @PostMapping("bulk-update-profile")
  public ResponseEntity<ResponseDto<BulkResult>> bulkUpdateArtistProfile(
      @Valid @RequestBody BulkDto<UpdateArtistProfileDto> bulkUpdateArtistProfileDtos) {
    final List<UpdateArtistProfileCommand> updateArtistCommands =
        bulkUpdateArtistProfileDtos.items().stream()
            .map(
                uad -> {
                  return UpdateArtistProfileCommand.builder()
                      .id(uad.id())
                      .profile(
                          ArtistProfile.builder()
                              .name(uad.name())
                              .biography(uad.biography())
                              .description(uad.description())
                              .thumbnailUrl(uad.thumbnailUrl())
                              .backgroundUrl(uad.backgroundUrl())
                              .refCode(uad.refCode())
                              .build())
                      .build();
                })
            .collect(Collectors.toList());
    final BulkResult bulkResult = commandDispatcher.send(updateArtistCommands);
    return ResponseEntity.ok(ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, bulkResult));
  }

  @Operation(operationId = "Bulk Delete Artist")
  @PostMapping("bulk-delete")
  public ResponseEntity<ResponseDto<BulkResult>> bulkDeleteArtist(
      @Valid @RequestBody BulkDto<DeleteArtistDto> bulkDeleteArtistDtos) {
    final List<DeleteArtistCommand> deleteArtistCommands =
        bulkDeleteArtistDtos.items().stream()
            .map(dad -> DeleteArtistCommand.builder().id(dad.id()).build())
            .collect(Collectors.toList());
    final BulkResult bulkResult = commandDispatcher.send(deleteArtistCommands);
    return ResponseEntity.ok(ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, bulkResult));
  }

  @Operation(operationId = "Bulk Release Artist")
  @PostMapping("bulk-release")
  public ResponseEntity<ResponseDto<BulkResult>> bulkReleaseArtist(
      @Valid @RequestBody BulkDto<ReleaseArtistDto> bulkReleaseArtistDtos) {
    final List<ReleaseArtistCommand> releaseArtistCommands =
        bulkReleaseArtistDtos.items().stream()
            .map(rad -> ReleaseArtistCommand.builder().id(rad.id()).build())
            .collect(Collectors.toList());
    final BulkResult bulkResult = commandDispatcher.send(releaseArtistCommands);
    return ResponseEntity.ok(ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, bulkResult));
  }

  @Operation(operationId = "Bulk Set Artist's visibility")
  @PostMapping("bulk-set-visibility")
  public ResponseEntity<ResponseDto<BulkResult>> bulkSetArtistVisibility(
      @Valid @RequestBody BulkDto<SetArtistVisibilityDto> bulkSetArtistVisibilityDtos) {
    final List<SetArtistVisibilityCommand> setArtistVisibilityCommands =
        bulkSetArtistVisibilityDtos.items().stream()
            .map(
                sav ->
                    SetArtistVisibilityCommand.builder()
                        .id(sav.id())
                        .isPublic(sav.isPublic())
                        .build())
            .collect(Collectors.toList());
    final BulkResult bulkResult = commandDispatcher.send(setArtistVisibilityCommands);
    return ResponseEntity.ok(ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, bulkResult));
  }
}
