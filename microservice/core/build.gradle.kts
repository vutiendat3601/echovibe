dependencies {
  compileOnly("org.springframework.boot:spring-boot-starter")
  compileOnly("org.springframework.boot:spring-boot-starter-web")
  compileOnly("org.springframework.boot:spring-boot-starter-data-mongodb")
  compileOnly("org.springframework.boot:spring-boot-starter-validation")
  compileOnly("com.nimbusds:nimbus-jose-jwt")
}

tasks {
  named("jib") {
    enabled = false
  }
  bootJar {
    enabled = false
  }
  jar {
    enabled = true
  }
}
