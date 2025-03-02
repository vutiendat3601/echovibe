package vn.io.echovibe.artist.command.controller;

import static vn.io.echovibe.artist.command.constant.ArtistConstant.ARTIST_PUBLISHED_SUCCESS;
import static vn.io.echovibe.core.constant.Constant.REQUEST_PROCESSED_SUCCESS;
import static vn.io.echovibe.core.utils.IdentityUtils.AGGREGATE_ID_LENGTH;
import static vn.io.echovibe.core.utils.IdentityUtils.AGGREGATE_ID_REGEX;

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
import vn.io.echovibe.artist.command.dto.CreateArtistDto;
import vn.io.echovibe.artist.command.dto.DeleteArtistDto;
import vn.io.echovibe.artist.command.dto.UpdateArtistDto;
import vn.io.echovibe.artist.command.model.CreateArtistCommand;
import vn.io.echovibe.artist.command.model.DeleteArtistCommand;
import vn.io.echovibe.artist.command.model.PublishArtistCommand;
import vn.io.echovibe.artist.command.model.UpdateArtistCommand;
import vn.io.echovibe.core.command.CommandDispatcher;
import vn.io.echovibe.core.dto.BulkDto;
import vn.io.echovibe.core.dto.EmptyObjectDto;
import vn.io.echovibe.core.dto.ResponseDto;
import vn.io.echovibe.core.model.BulkResult;
import vn.io.echovibe.core.utils.IdentityUtils;

@Tag(name = "Artist")
@RequiredArgsConstructor
@Slf4j
@RequestMapping("v1/artists")
@RestController
public class ArtistController {
  private final CommandDispatcher commandDispatcher;

  @Operation(operationId = "Bulk Create Artist")
  @PostMapping("/bulk-create")
  public ResponseEntity<ResponseDto<BulkResult>> createArtist(
      @Valid @RequestBody BulkDto<CreateArtistDto> bulkCreateDto) {
    final List<CreateArtistCommand> createArtistCommands =
        bulkCreateDto.items().stream()
            .map(
                cad ->
                    CreateArtistCommand.builder()
                        .id(IdentityUtils.generateAggregateId())
                        .name(cad.name())
                        .isPublic(cad.isPublic())
                        .description(cad.description())
                        .build())
            .collect(Collectors.toList());
    final BulkResult bulkResult = commandDispatcher.send(createArtistCommands);
    return ResponseEntity.ok(ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, bulkResult));
  }

  @Operation(operationId = "Bulk Update Artist")
  @PostMapping("bulk-update")
  public ResponseEntity<ResponseDto<BulkResult>> updateArtist(
      @Valid @RequestBody BulkDto<UpdateArtistDto> bulkUpdateDto) {
    final List<UpdateArtistCommand> updateArtistCommands =
        bulkUpdateDto.items().stream()
            .map(
                uad ->
                    UpdateArtistCommand.builder()
                        .id(uad.id())
                        .name(uad.name())
                        .isPublic(uad.isPublic())
                        .description(uad.description())
                        .build())
            .collect(Collectors.toList());
    final BulkResult bulkResult = commandDispatcher.send(updateArtistCommands);
    return ResponseEntity.ok(ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, bulkResult));
  }

  @Operation(operationId = "Bulk Delete Artist")
  @PostMapping("bulk-delete")
  public ResponseEntity<ResponseDto<BulkResult>> deleteArtist(
      @Valid @RequestBody BulkDto<DeleteArtistDto> bulkDeleteDto) {
    final List<DeleteArtistCommand> deleteArtistCommands =
        bulkDeleteDto.items().stream()
            .map(dad -> DeleteArtistCommand.builder().id(dad.id()).build())
            .collect(Collectors.toList());
    final BulkResult bulkResult = commandDispatcher.send(deleteArtistCommands);
    return ResponseEntity.ok(ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, bulkResult));
  }

  @Operation(operationId = "Publish Artist")
  @PostMapping("{id}/publish")
  public ResponseEntity<ResponseDto<EmptyObjectDto>> publishArtist(
      @Valid
          @Pattern(
              regexp = AGGREGATE_ID_REGEX,
              message = "Artist ID must contain [A-Z, a-z, 0-9] only.")
          @Length(
              min = AGGREGATE_ID_LENGTH,
              max = AGGREGATE_ID_LENGTH,
              message = "Artist ID must contain " + AGGREGATE_ID_LENGTH + " characters only.")
          @PathVariable
          String id) {
    final PublishArtistCommand publishArtistCommand = new PublishArtistCommand(id);
    commandDispatcher.send(publishArtistCommand);
    return ResponseEntity.ok(ResponseDto.ok(ARTIST_PUBLISHED_SUCCESS));
  }
}
