package vn.io.echovibe.artist.command.controller;

import static vn.io.echovibe.artist.command.constant.ArtistConstant.ARTIST_CREATED_SUCCESS;
import static vn.io.echovibe.artist.command.constant.ArtistConstant.ARTIST_DELETED_SUCCESS;
import static vn.io.echovibe.artist.command.constant.ArtistConstant.ARTIST_PUBLISHED_SUCCESS;
import static vn.io.echovibe.artist.command.constant.ArtistConstant.ARTIST_UPDATED_SUCCESS;
import static vn.io.echovibe.core.utils.IdentityUtils.AGGREGATE_ID_LENGTH;
import static vn.io.echovibe.core.utils.IdentityUtils.AGGREGATE_ID_REGEX;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Pattern;
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
import vn.io.echovibe.artist.command.dto.UpdateArtistDto;
import vn.io.echovibe.artist.command.model.CreateArtistCommand;
import vn.io.echovibe.artist.command.model.DeleteArtistCommand;
import vn.io.echovibe.artist.command.model.PublishArtistCommand;
import vn.io.echovibe.artist.command.model.UpdateArtistCommand;
import vn.io.echovibe.core.command.CommandDispatcher;
import vn.io.echovibe.core.dto.EmptyObjectDto;
import vn.io.echovibe.core.dto.IdDto;
import vn.io.echovibe.core.dto.ResponseDto;

@Tag(name = "Artist")
@RequiredArgsConstructor
@Slf4j
@RequestMapping("v1/artists")
@RestController
public class ArtistController {
  private final CommandDispatcher commandDispatcher;

  @Operation(description = "Create Artist")
  @PostMapping("create")
  public ResponseEntity<ResponseDto<IdDto>> createArtist(
      @Valid @RequestBody CreateArtistDto createArtistDto) {
    final CreateArtistCommand createArtistCommand =
        CreateArtistCommand.builder()
            .name(createArtistDto.name())
            .isPublic(createArtistDto.isPublic())
            .description(createArtistDto.description())
            .build();
    commandDispatcher.send(createArtistCommand);
    return ResponseEntity.ok(ResponseDto.ok(ARTIST_CREATED_SUCCESS, createArtistCommand.getId()));
  }

  @Operation(description = "Update Artist")
  @PostMapping("{id}/update")
  public ResponseEntity<ResponseDto<EmptyObjectDto>> updateArtist(
      @PathVariable String id, @RequestBody UpdateArtistDto updateArtistDto) {
    final UpdateArtistCommand updateArtistCommand =
        UpdateArtistCommand.builder()
            .id(id)
            .name(updateArtistDto.name())
            .isPublic(updateArtistDto.isPublic())
            .description(updateArtistDto.description())
            .build();
    commandDispatcher.send(updateArtistCommand);
    return ResponseEntity.ok(ResponseDto.ok(ARTIST_UPDATED_SUCCESS));
  }

  @Operation(description = "Publish Artist")
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

  @Operation(description = "Delete Artist")
  @PostMapping("{id}/delete")
  public ResponseEntity<ResponseDto<EmptyObjectDto>> deleteArtist(@PathVariable String id) {
    final DeleteArtistCommand deleteArtistCommand = new DeleteArtistCommand(id);
    commandDispatcher.send(deleteArtistCommand);
    return ResponseEntity.ok(ResponseDto.ok(ARTIST_DELETED_SUCCESS));
  }
}
