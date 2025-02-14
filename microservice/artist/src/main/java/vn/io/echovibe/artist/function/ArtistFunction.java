package vn.io.echovibe.artist.function;

import java.util.function.Consumer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import vn.io.echovibe.artist.dto.CreateArtistDto;
import vn.io.echovibe.artist.service.ArtistService;

@Configuration
public class ArtistFunction {

  @Bean
  Consumer<CreateArtistDto> createArtist(ArtistService artistService) {
    return createArtistDto -> {
      artistService.createArtist(createArtistDto);
    };
  }
}
