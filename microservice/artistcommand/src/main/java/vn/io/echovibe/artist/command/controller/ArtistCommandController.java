package vn.io.echovibe.artist.command.controller;

import static vn.io.echovibe.core.constant.Constant.REQUEST_PROCESSED_SUCCESS;

import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import vn.io.echovibe.artist.command.dto.ArtistProfileDto;
import vn.io.echovibe.artist.command.dto.CreateArtistDto;
import vn.io.echovibe.artist.command.dto.DeleteArtistDto;
import vn.io.echovibe.artist.command.dto.ReleaseArtistDto;
import vn.io.echovibe.artist.command.dto.SetArtistVisibilityDto;
import vn.io.echovibe.artist.command.dto.UpdateArtistDto;
import vn.io.echovibe.artist.command.model.CreateArtistCommand;
import vn.io.echovibe.artist.command.model.DeleteArtistCommand;
import vn.io.echovibe.artist.command.model.ReleaseArtistCommand;
import vn.io.echovibe.artist.command.model.SetArtistVerificationCommand;
import vn.io.echovibe.artist.command.model.UpdateArtistCommand;
import vn.io.echovibe.artist.common.model.ArtistProfile;
import vn.io.echovibe.artist.common.model.Tag;
import vn.io.echovibe.core.command.CommandDispatcher;
import vn.io.echovibe.core.model.BulkResult;
import vn.io.echovibe.core.util.IdentityUtils;
import vn.io.echovibe.web.dto.BulkDto;
import vn.io.echovibe.web.dto.ResponseDto;

@io.swagger.v3.oas.annotations.tags.Tag(name = "Artist")
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
                  final ArtistProfileDto createArtistProfileDto = cad.profile();
                  return CreateArtistCommand.builder()
                      .id(IdentityUtils.generateAggregateId())
                      .refCode(cad.refCode())
                      .isPublic(Optional.of(cad.isPublic()).orElse(false))
                      .tags(
                          cad.tags().stream()
                              .map(tagDto -> new Tag(tagDto.name(), tagDto.isActive()))
                              .collect(Collectors.toList()))
                      .profile(
                          ArtistProfile.builder()
                              .name(createArtistProfileDto.name())
                              .biography(createArtistProfileDto.biography())
                              .description(createArtistProfileDto.description())
                              .thumbnailUrl(createArtistProfileDto.thumbnailUrl())
                              .backgroundUrl(createArtistProfileDto.backgroundUrl())
                              .nationalityIsoCode(createArtistProfileDto.nationalityIsoCode())
                              .build())
                      .build();
                })
            .collect(Collectors.toList());
    final BulkResult bulkResult = commandDispatcher.send(createArtistCommands);
    return ResponseEntity.ok(ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, bulkResult));
  }

  @Operation(operationId = "Bulk Update Artist")
  @PostMapping("bulk-update")
  public ResponseEntity<ResponseDto<BulkResult>> bulkUpdateArtistProfile(
      @Valid @RequestBody BulkDto<UpdateArtistDto> bulkUpdateArtistDtos) {
    final List<UpdateArtistCommand> updateArtistCommands =
        bulkUpdateArtistDtos.items().stream()
            .map(
                uad -> {
                  final ArtistProfile profile =
                      ArtistProfile.builder()
                          .name(uad.profile().name())
                          .biography(uad.profile().biography())
                          .description(uad.profile().description())
                          .thumbnailUrl(uad.profile().thumbnailUrl())
                          .backgroundUrl(uad.profile().backgroundUrl())
                          .nationalityIsoCode(uad.profile().nationalityIsoCode())
                          .build();
                  return UpdateArtistCommand.builder()
                      .id(uad.id())
                      .refCode(uad.refCode())
                      .isPublic(uad.isPublic())
                      .tags(
                          uad.tags().stream()
                              .map(tagDto -> new Tag(tagDto.name(), tagDto.isActive()))
                              .collect(Collectors.toList()))
                      .profile(profile)
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

  @Operation(operationId = "Bulk Set Artist's verification")
  @PostMapping("bulk-set-verification")
  public ResponseEntity<ResponseDto<BulkResult>> bulkSetArtistVerification(
      @Valid @RequestBody BulkDto<SetArtistVisibilityDto> bulkSetArtistVisibilityDtos) {
    final List<SetArtistVerificationCommand> setArtistVisibilityCommands =
        bulkSetArtistVisibilityDtos.items().stream()
            .map(
                sav ->
                    SetArtistVerificationCommand.builder()
                        .id(sav.id())
                        .isVerified(sav.isVerified())
                        .build())
            .collect(Collectors.toList());
    final BulkResult bulkResult = commandDispatcher.send(setArtistVisibilityCommands);
    return ResponseEntity.ok(ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, bulkResult));
  }
}
