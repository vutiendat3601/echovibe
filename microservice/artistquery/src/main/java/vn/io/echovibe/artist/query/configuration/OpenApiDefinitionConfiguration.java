package vn.io.echovibe.artist.query.configuration;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Info;
import io.swagger.v3.oas.annotations.servers.Server;

@OpenAPIDefinition(
    servers = {
      @Server(url = "http://localho.st:6110", description = "local"),
    },
    info =
        @Info(
            title = "Echovibe - Artist Query APIs",
            version = "1.0",
            description =
                "Echovibe - Artist Query APIs contains APIs which query data related to artist."))
public class OpenApiDefinitionConfiguration {}
