package vn.io.echovibe.playlist.command.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;
import vn.io.echovibe.core.command.Command;

@SuperBuilder
@ToString
@Getter
@Setter
@NoArgsConstructor
public class ReleasePlaylistCommand extends Command {}
