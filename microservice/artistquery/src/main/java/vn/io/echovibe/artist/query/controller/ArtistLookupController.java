package vn.io.echovibe.artist.query.controller;

import static vn.io.echovibe.core.constant.Constant.REQUEST_PROCESSED_SUCCESS;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import vn.io.echovibe.artist.query.model.FindArtistByIdQuery;
import vn.io.echovibe.artist.query.model.FindArtistPageQuery;
import vn.io.echovibe.core.dto.ResponseDto;
import vn.io.echovibe.core.model.QueryResult;
import vn.io.echovibe.core.query.QueryDispatcher;

@RequiredArgsConstructor
@RequestMapping("v1/artists")
@RestController
public class ArtistLookupController {
  private final QueryDispatcher queryDispatcher;

  @GetMapping(path = "byId/{id}")
  public ResponseDto<QueryResult> getArtistById(@PathVariable String id) {
    final FindArtistByIdQuery findArtistByIdQuery = FindArtistByIdQuery.builder().id(id).build();
    final QueryResult queryResult = queryDispatcher.send(findArtistByIdQuery);
    return ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, queryResult);
  }

  @GetMapping
  public ResponseDto<QueryResult> getArtistPage(
      @RequestParam(defaultValue = "0") Integer page,
      @RequestParam(defaultValue = "50") Integer size) {
    final FindArtistPageQuery findArtistPageQuery =
        FindArtistPageQuery.builder().page(page).size(size).build();
    final QueryResult queryResult = queryDispatcher.send(findArtistPageQuery);
    return ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, queryResult);
  }
}
