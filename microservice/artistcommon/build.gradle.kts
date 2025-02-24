dependencies {
  implementation(project(":core"))
}

tasks {
  bootJar {
    enabled = false
  }
  jar {
    enabled = true
  }
}
