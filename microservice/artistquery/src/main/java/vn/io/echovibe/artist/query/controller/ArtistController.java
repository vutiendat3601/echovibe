package vn.io.echovibe.artist.controller;

import static vn.io.echovibe.artist.constant.ArtistConstant.ARTIST_CREATED_SUCCESS;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import vn.io.echovibe.artist.command.CreateArtistCommand;
import vn.io.echovibe.artist.dispatcher.ArtistService;
import vn.io.echovibe.artist.dto.CreateArtistDto;
import vn.io.echovibe.core.command.CommandDispatcher;
import vn.io.echovibe.core.dto.ResponseDto;

@RequiredArgsConstructor
@RequestMapping("v1/artists")
@RestController
public class ArtistController {
  private final CommandDispatcher commandDispatcher;

  @PostMapping
  public ResponseEntity<ResponseDto<?>> createArtist(
      @Valid @RequestBody CreateArtistDto createArtistDto) {
    // artistService.createArtist(createArtistDto);
    final CreateArtistCommand createArtistCommand =
        CreateArtistCommand.builder()
            .name(createArtistDto.name())
            .description(createArtistDto.description())
            .build();
    // commandDispatcher.send
    return ResponseEntity.ok(ResponseDto.ok(ARTIST_CREATED_SUCCESS));
  }
}
