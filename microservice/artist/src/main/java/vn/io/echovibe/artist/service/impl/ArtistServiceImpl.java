package vn.io.echovibe.artist.service.impl;

import java.util.UUID;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.stream.function.StreamBridge;
import org.springframework.stereotype.Service;
import vn.io.echovibe.artist.dao.ArtistDao;
import vn.io.echovibe.artist.dto.CreateArtistDetailsDto;
import vn.io.echovibe.artist.dto.CreateArtistDto;
import vn.io.echovibe.artist.entity.Artist;
import vn.io.echovibe.artist.service.ArtistService;
import vn.io.echovibe.core.configuration.SystemConfiguration;

@Slf4j
@RequiredArgsConstructor
@Service
public class ArtistServiceImpl implements ArtistService {
  private final ArtistDao artistDao;
  private final StreamBridge streamBridge;
  private final SystemConfiguration sysConf;

  @Override
  public void createArtist(CreateArtistDto createArtistDto) {
    final UUID id = UUID.randomUUID();
    final String urn = "%s:artist:%s".formatted(sysConf.getUrnPrefix(), id);
    final Artist artist =
        Artist.builder()
            .id(id)
            .urn(urn)
            .name(createArtistDto.name())
            .isPublic(createArtistDto.isPublic())
            .description(createArtistDto.description())
            .build();
    artistDao
        .insertArtist(artist)
        .ifPresent(
            createdArtist -> {
              final CreateArtistDetailsDto createArtistDetailsDto =
                  new CreateArtistDetailsDto(
                      createdArtist.getId(),
                      createdArtist.getUrn(),
                      createdArtist.getName(),
                      createdArtist.getIsPublic(),
                      createdArtist.getDescription(),
                      createdArtist.getThumbnailFileKey(),
                      createdArtist.getBackgroundFileKey());
              createProductArtistDetails(createArtistDetailsDto);
            });
  }

  private void createProductArtistDetails(CreateArtistDetailsDto createArtistDetailsDto) {
    log.info("Sending request: createProductArtist={}", createArtistDetailsDto);
    final boolean isSent = streamBridge.send("createArtistDetails-out-0", createArtistDetailsDto);
    log.info("Sent request: createProductArtist={}, status={}", createArtistDetailsDto, isSent);
  }
}
