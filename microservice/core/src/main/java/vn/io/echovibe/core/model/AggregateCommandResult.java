package vn.io.echovibe.core.model;

public record AggregateCommandResult(
    String id, String command, Boolean isSuccessful, String message) {}
