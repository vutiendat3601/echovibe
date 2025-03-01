package vn.io.echovibe.artist.query.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import vn.io.echovibe.core.query.QueryDispatcher;

@RequiredArgsConstructor
@RequestMapping("v1/artists")
@RestController
public class ArtistController {
  private final QueryDispatcher queryDispatcher;
}
