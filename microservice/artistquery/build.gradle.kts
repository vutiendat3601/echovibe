dependencies {
  implementation(project(":core"))
  implementation(project(":artistcommon"))
  implementation("org.flywaydb:flyway-core")
  implementation("org.flywaydb:flyway-database-postgresql")
  implementation("org.springframework.boot:spring-boot-starter-validation")
  implementation("org.springframework.boot:spring-boot-starter-web")
  implementation("org.springframework.boot:spring-boot-starter-data-jpa")
  implementation("org.springframework.cloud:spring-cloud-starter-stream-kafka")
  implementation("org.springframework.cloud:spring-cloud-stream-binder-kafka-streams")
  implementation("io.hypersistence:hypersistence-utils-hibernate-63")
  implementation("org.springframework.boot:spring-boot-starter-actuator")
  implementation("de.codecentric:spring-boot-admin-starter-client")
  implementation("org.springdoc:springdoc-openapi-starter-webmvc-ui")
  implementation("com.nimbusds:nimbus-jose-jwt")

  developmentOnly("org.springframework.boot:spring-boot-docker-compose")
  runtimeOnly("org.postgresql:postgresql")

  testImplementation("org.springframework.cloud:spring-cloud-stream-test-binder")
}
