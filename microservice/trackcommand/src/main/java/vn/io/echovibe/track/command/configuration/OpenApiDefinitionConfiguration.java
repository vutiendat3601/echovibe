package vn.io.echovibe.track.command.configuration;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Info;
import io.swagger.v3.oas.annotations.servers.Server;

@OpenAPIDefinition(
    servers = {
      @Server(url = "http://localho.st:6120", description = "local"),
    },
    info =
        @Info(
            title = "Echo Vibe - Track Command APIs",
            version = "1.0",
            description =
                """
Echo Vibe - Track Command APIs contains APIs which create or change data related to artist.\
"""))
public class OpenApiDefinitionConfiguration {}
