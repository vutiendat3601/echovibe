package vn.io.echovibe.artist;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@ComponentScan("vn.io.echovibe")
@SpringBootApplication
public class ArtistApplication {
  public static void main(String[] args) {
    SpringApplication.run(ArtistApplication.class, args);
  }
}
