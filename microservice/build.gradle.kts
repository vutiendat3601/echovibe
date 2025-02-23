import java.time.ZonedDateTime
import java.time.format.DateTimeFormatter
import java.time.ZoneOffset

plugins {
  java
  alias(libs.plugins.springBootPlugin)
  alias(libs.plugins.springDependencyManagementPlugin)
  alias(libs.plugins.spotlessPlugin)
  alias(libs.plugins.googleJibPlugin)
}


allprojects {
  group = "vn.io.echovibe"
  version = "1.0.0"

  repositories {
    mavenCentral()
  }
}

subprojects {
  apply(plugin = "java")
  apply(plugin = rootProject.libs.plugins.springBootPlugin.get().pluginId)
  apply(plugin = rootProject.libs.plugins.springDependencyManagementPlugin.get().pluginId)
  apply(plugin = rootProject.libs.plugins.spotlessPlugin.get().pluginId)
  apply(plugin = rootProject.libs.plugins.googleJibPlugin.get().pluginId)

  dependencyManagement {
    imports {
      mavenBom("de.codecentric:spring-boot-admin-dependencies:${rootProject.libs.versions.springBootAdminVersion.get()}")
      mavenBom("org.springframework.cloud:spring-cloud-dependencies:${rootProject.libs.versions.springCloudVersion.get()}")
      mavenBom("io.netty:netty-all:${rootProject.libs.versions.nettyAllVersion.get()}")
    }
    dependencies {
      dependency("io.hypersistence:hypersistence-utils-hibernate-63:${rootProject.libs.versions.hypersistenceUtilsHibernate63Version.get()}")
      dependency("org.springdoc:springdoc-openapi-starter-webmvc-ui:${rootProject.libs.versions.springDocOpenApiVersion.get()}")
      dependency("com.nimbusds:nimbus-jose-jwt:${rootProject.libs.versions.nimbusJoseJwtVersion.get()}")
    }
  }

  dependencies {
    implementation("org.springframework.boot:spring-boot-starter")
    compileOnly("org.projectlombok:lombok")
    annotationProcessor("org.projectlombok:lombok")

    testImplementation("org.springframework.boot:spring-boot-starter-test")
    testRuntimeOnly("org.junit.platform:junit-platform-launcher")
  }

  java {
    toolchain {
      languageVersion = JavaLanguageVersion.of(rootProject.libs.versions.javaVersion.get())
    }
    sourceCompatibility = JavaVersion.valueOf(rootProject.libs.versions.javaSourceCompatibility.get())
    targetCompatibility = JavaVersion.valueOf(rootProject.libs.versions.javaTargetCompatibility.get())
  }

  configurations {
    compileOnly {
      extendsFrom(configurations.annotationProcessor.get())
    }
  }

  tasks.withType<JavaCompile> {
    options.encoding = "UTF-8"
  }

  tasks.withType<Javadoc>{
    options.encoding = "UTF-8"
  }

  spotless {
    java {
      googleJavaFormat()
    }
  }

  jib {
    from {
      image = "bellsoft/liberica-openjre-alpine:${rootProject.libs.versions.javaVersion.get()}-cds"
      platforms {
        platform {
          architecture = "amd64"
          os = "linux"
        }
        platform {
          architecture = "arm64"
          os = "linux"
        }
      }
    }
    to {
      val BUILD_VERSION = ZonedDateTime.now(ZoneOffset.UTC).format(DateTimeFormatter.ofPattern("yyyyMMdd.HHmmss"))
      image = "vutiendat3601/echovibe-${project.name}"
      tags = setOf("${BUILD_VERSION}", "latest")
    }
  }
}

tasks {
  bootJar {
    enabled = false
  }
  jar {
    enabled = false
  }
}
