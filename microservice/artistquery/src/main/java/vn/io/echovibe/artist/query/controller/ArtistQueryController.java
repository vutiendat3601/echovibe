package vn.io.echovibe.artist.query.controller;

import static vn.io.echovibe.core.constant.Constant.REQUEST_PROCESSED_SUCCESS;

import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.constraints.PositiveOrZero;
import jakarta.validation.constraints.Size;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.hibernate.validator.constraints.Range;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import vn.io.echovibe.artist.query.model.FindArtistByIdQuery;
import vn.io.echovibe.artist.query.model.FindArtistByParamQuery;
import vn.io.echovibe.artist.query.model.FindArtistPageQuery;
import vn.io.echovibe.core.annotation.IsoCountryCode;
import vn.io.echovibe.core.dto.ResponseDto;
import vn.io.echovibe.core.model.QueryResult;
import vn.io.echovibe.core.query.QueryDispatcher;

@RequiredArgsConstructor
@RequestMapping("v1/artists")
@RestController
public class ArtistQueryController {
  private final QueryDispatcher queryDispatcher;

  @Operation(operationId = "Get Artist By id")
  @GetMapping(path = "get/byId/{id}")
  public ResponseDto<QueryResult> getArtistById(@PathVariable String id) {
    final FindArtistByIdQuery findArtistByIdQuery = FindArtistByIdQuery.builder().id(id).build();
    final QueryResult queryResult = queryDispatcher.send(findArtistByIdQuery);
    return ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, queryResult);
  }

  @Operation(operationId = "Get Artist By params")
  @GetMapping(path = "get/byParam")
  public ResponseDto<QueryResult> getArtistByParam(
      @IsoCountryCode(message = "Field 'market' must match ISO 3166-1 Alpha-2 Country Code")
          @RequestParam
          String market,
      @Size(message = "Field 'ids' must have size in range [1, 50]", min = 1, max = 50)
          @RequestParam
          List<String> ids) {
    final FindArtistByParamQuery findArtistByIdQuery =
        FindArtistByParamQuery.builder().ids(ids).build();
    final QueryResult queryResult = queryDispatcher.send(findArtistByIdQuery);
    return ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, queryResult);
  }

  @Operation(operationId = "Get Artist Page")
  @GetMapping
  public ResponseDto<QueryResult> getArtistPage(
      @PositiveOrZero(message = "Field 'page' must be positive or zero.")
          @RequestParam(defaultValue = "0")
          Integer page,
      @Range(min = 10, max = 100, message = "Field 'size' must be in range [10, 100].")
          @RequestParam(defaultValue = "50")
          Integer size) {
    final FindArtistPageQuery findArtistPageQuery =
        FindArtistPageQuery.builder().page(page).size(size).build();
    final QueryResult queryResult = queryDispatcher.send(findArtistPageQuery);
    return ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, queryResult);
  }
}
