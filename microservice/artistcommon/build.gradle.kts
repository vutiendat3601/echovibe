dependencies {
  implementation(project(":core"))
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
