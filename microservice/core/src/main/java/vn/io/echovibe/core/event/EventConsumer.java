package vn.io.echovibe.core.event;

import java.util.function.Consumer;

public interface EventConsumer<E extends Event> extends Consumer<E> {}
