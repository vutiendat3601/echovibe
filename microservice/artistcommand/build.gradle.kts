dependencies {
  implementation(project(":core"))
  implementation("org.springframework.boot:spring-boot-starter-validation")
  implementation("org.springframework.boot:spring-boot-starter-web")
  implementation("org.springframework.cloud:spring-cloud-stream-binder-kafka")
  implementation("io.hypersistence:hypersistence-utils-hibernate-63")
  implementation("org.springframework.boot:spring-boot-starter-actuator")
  implementation("de.codecentric:spring-boot-admin-starter-client")
  implementation("org.springdoc:springdoc-openapi-starter-webmvc-ui")
  implementation("org.springframework.boot:spring-boot-starter-data-mongodb")
  implementation("com.nimbusds:nimbus-jose-jwt")

  developmentOnly("org.springframework.boot:spring-boot-docker-compose")

  testImplementation("org.springframework.cloud:spring-cloud-stream-test-binder")
}
