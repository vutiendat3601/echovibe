package vn.io.echovibe.core.model;

public record CommandResult(String id, String command, Boolean isSuccessful, String message) {}
