package vn.io.echovibe.artist.command;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.data.mongodb.repository.config.EnableMongoRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import vn.io.echovibe.core.event.EventStoreRepository;

@ComponentScan("vn.io.echovibe")
@EnableJpaRepositories("vn.io.echovibe")
@EnableMongoRepositories(basePackageClasses = {EventStoreRepository.class})
@EnableTransactionManagement
@SpringBootApplication
public class ArtistQueryApplication {
  public static void main(String[] args) {
    SpringApplication.run(ArtistQueryApplication.class, args);
  }
}
