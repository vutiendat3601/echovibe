dependencies {
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
