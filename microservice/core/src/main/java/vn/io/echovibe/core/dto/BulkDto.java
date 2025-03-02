package vn.io.echovibe.core.dto;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import java.util.List;

public record BulkDto<T>(@Valid @NotEmpty List<T> items) {}
