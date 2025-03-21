package vn.io.echovibe.core.model;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import vn.io.echovibe.core.exception.Error;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class CommandResult {
  String id;

  String command;

  Boolean isSuccessful;

  List<Error> errors;

  String message;
}
