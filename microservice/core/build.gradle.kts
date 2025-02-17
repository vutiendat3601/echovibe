dependencies {
  implementation("org.springframework.boot:spring-boot-starter")
  implementation("org.springframework.boot:spring-boot-starter-web")
  implementation("org.springframework.boot:spring-boot-starter-data-jpa")
  implementation("org.springframework.boot:spring-boot-starter-data-mongodb")
}

tasks {
  bootJar {
    enabled = false
  }
  jar {
    enabled = true
  }
}
