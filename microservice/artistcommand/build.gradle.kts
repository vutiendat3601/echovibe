dependencies {
  implementation(project(":core"))
  implementation(project(":web"))
  implementation(project(":artistcommon"))
  implementation("org.springframework.boot:spring-boot-starter-data-mongodb")
  implementation("org.springframework.boot:spring-boot-starter-validation")
  implementation("org.springframework.boot:spring-boot-starter-web")
  implementation("org.springframework.cloud:spring-cloud-starter-stream-kafka")
  implementation("org.springframework.cloud:spring-cloud-stream-binder-kafka-streams")
  implementation("org.springframework.boot:spring-boot-starter-actuator")
  implementation("org.springdoc:springdoc-openapi-starter-webmvc-ui")
  implementation("de.codecentric:spring-boot-admin-starter-client")
  implementation("com.nimbusds:nimbus-jose-jwt")

  developmentOnly("org.springframework.boot:spring-boot-docker-compose")
  testImplementation("org.springframework.cloud:spring-cloud-stream-test-binder")
}
