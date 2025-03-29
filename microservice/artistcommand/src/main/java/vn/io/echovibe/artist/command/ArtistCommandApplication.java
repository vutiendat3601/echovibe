package vn.io.echovibe.artist.command;

import lombok.RequiredArgsConstructor;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.mongodb.repository.config.EnableMongoRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import vn.io.echovibe.client.rest.ArtistQueryClient;
import vn.io.echovibe.core.domain.EventStoreRepository;

@ComponentScan("vn.io.echovibe")
@EnableMongoRepositories(basePackageClasses = EventStoreRepository.class)
@EnableTransactionManagement
@RequiredArgsConstructor
@EnableFeignClients(clients = {ArtistQueryClient.class})
@SpringBootApplication
public class ArtistCommandApplication {

  public static void main(String[] args) {
    SpringApplication.run(ArtistCommandApplication.class, args);
  }
}
