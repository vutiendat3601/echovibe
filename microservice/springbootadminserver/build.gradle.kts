dependencies {
  implementation("org.springframework.boot:spring-boot-starter-web")
	implementation("de.codecentric:spring-boot-admin-starter-server")
  implementation("io.netty:netty-all")

	testImplementation("org.springframework.boot:spring-boot-starter-test")
	testRuntimeOnly("org.junit.platform:junit-platform-launcher")
}

tasks {
  bootJar {
    enabled = false
  }
  jar {
    enabled = true
  }
}
