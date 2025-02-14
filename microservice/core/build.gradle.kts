dependencies {
  implementation("org.springframework.boot:spring-boot-starter-data-jpa")
  implementation("org.springframework.boot:spring-boot-starter")
}

tasks {
  bootJar {
    enabled = false
  }
  jar {
    enabled = true
  }
}
