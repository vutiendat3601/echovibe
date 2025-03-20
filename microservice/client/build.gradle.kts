dependencies {
  implementation(project(":web"))
  implementation(project(":artistcommon"))
  compileOnly("org.springframework.cloud:spring-cloud-starter-openfeign")
  compileOnly("org.springframework.boot:spring-boot-starter-web")
}

tasks {
  listOf("jib", "jibBuildTar", "jibDockerBuild").forEach {
    named(it) {
      enabled = false
    }
  }
  bootJar {
    enabled = false
  }
  jar {
    enabled = true
  }
}
