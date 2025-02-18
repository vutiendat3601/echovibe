dependencies {
  compileOnly("org.springframework.boot:spring-boot-starter")
  compileOnly("org.springframework.boot:spring-boot-starter-web")
  compileOnly("org.springframework.boot:spring-boot-starter-data-jpa")
  compileOnly("org.springframework.boot:spring-boot-starter-data-mongodb")
}

tasks {
  bootJar {
    enabled = false
  }
  jar {
    enabled = true
  }
}
