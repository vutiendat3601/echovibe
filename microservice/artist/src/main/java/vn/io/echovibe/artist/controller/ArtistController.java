package vn.io.echovibe.artist.controller;

import static vn.io.echovibe.artist.constant.ArtistConstant.ARTIST_CREATED_SUCCESS;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import vn.io.echovibe.artist.dto.CreateArtistDto;
import vn.io.echovibe.artist.service.ArtistService;
import vn.io.echovibe.core.dto.ResponseDto;

@RequiredArgsConstructor
@RequestMapping("v1/artists")
@RestController
public class ArtistController {
  private final ArtistService artistService;

  @PostMapping
  public ResponseEntity<ResponseDto<?>> createArtist(
      @Valid @RequestBody CreateArtistDto createArtistDto) {
    artistService.createArtist(createArtistDto);
    return ResponseEntity.ok(ResponseDto.ok(ARTIST_CREATED_SUCCESS));
  }
}
