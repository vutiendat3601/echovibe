package vn.io.echovibe.artist.query.controller;

import static vn.io.echovibe.core.constant.Constant.REQUEST_PROCESSED_SUCCESS;

import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.constraints.Size;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import vn.io.echovibe.artist.query.model.FindArtistByIdsQuery;
import vn.io.echovibe.core.dto.ResponseDto;
import vn.io.echovibe.core.model.QueryResult;
import vn.io.echovibe.core.query.QueryDispatcher;

@RequiredArgsConstructor
@RequestMapping("v1/artists")
@RestController
public class ArtistQueryController {
  private final QueryDispatcher queryDispatcher;

  @Operation(operationId = "Get Artist by ids")
  @GetMapping
  public ResponseDto<QueryResult> getArtistByIds(
      @Size(message = "Field 'ids' must have size in range [1, 50]", min = 1, max = 50)
          @RequestParam
          List<String> ids) {
    final FindArtistByIdsQuery findArtistByIdQuery =
        FindArtistByIdsQuery.builder().ids(ids).build();
    final QueryResult queryResult = queryDispatcher.send(findArtistByIdQuery);
    return ResponseDto.ok(REQUEST_PROCESSED_SUCCESS, queryResult);
  }
}
