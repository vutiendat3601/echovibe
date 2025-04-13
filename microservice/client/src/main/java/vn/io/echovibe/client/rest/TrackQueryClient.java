package vn.io.echovibe.client.rest;

import java.util.List;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import vn.io.echovibe.track.common.dto.TrackDto;
import vn.io.echovibe.web.dto.ResponseDto;

@FeignClient(name = "trackQueryClient", url = "${app.web.client.trackquery.baseUrl}")
public interface TrackQueryClient {
  @GetMapping("v1/tracks/byId")
  ResponseEntity<ResponseDto<List<TrackDto>>> getTrackByIds(@RequestParam("ids") String ids);

  @GetMapping("v1/tracks/byRefCode")
  ResponseEntity<ResponseDto<List<TrackDto>>> getTrackByRefCodes(
      @RequestParam("refCodes") String refCodes);
}
