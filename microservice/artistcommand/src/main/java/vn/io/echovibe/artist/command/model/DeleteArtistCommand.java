package vn.io.echovibe.artist.command.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;
import vn.io.echovibe.core.command.Command;

@SuperBuilder
@ToString
@Getter
@Setter
@AllArgsConstructor
public class DeleteArtistCommand extends Command {}
