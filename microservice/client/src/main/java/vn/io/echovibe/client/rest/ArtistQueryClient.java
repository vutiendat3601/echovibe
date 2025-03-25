package vn.io.echovibe.client.rest;

import java.util.List;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import vn.io.echovibe.artist.common.dto.ArtistDto;
import vn.io.echovibe.web.dto.ResponseDto;

@FeignClient(name = "artistQueryClient", url = "${app.web.client.artistquery.baseUrl}")
public interface ArtistQueryClient {
  @GetMapping("v1/artists/byId")
  ResponseEntity<ResponseDto<List<ArtistDto>>> getArtistByIds(
      @RequestParam("ids") List<String> ids);

  @GetMapping("v1/artists/byRefCode")
  ResponseEntity<ResponseDto<List<ArtistDto>>> getArtistByRefCodes(
      @RequestParam("refCodes") List<String> refCodes);
}
