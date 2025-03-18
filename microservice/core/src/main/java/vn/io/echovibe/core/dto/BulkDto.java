package vn.io.echovibe.core.dto;

import java.util.List;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;

public record BulkDto<T>(@NotEmpty List<@Valid T> items) {}
