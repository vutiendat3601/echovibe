package vn.io.echovibe.web.dto;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import java.util.List;

public record BulkDto<T>(@NotEmpty List<@Valid T> items) {}
