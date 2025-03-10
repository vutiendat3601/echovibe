import logging


class Logger:
    """Default logger for app."""

    def __init__(self):
        logging.basicConfig(datefmt='%Y-%m-%d %H:%M:%S',
                            force='%(asctime)-s|%(levelname)s| %(message)s',
                            level=logging.DEBUG)
        logging.addLevelName(
            logging.DEBUG,
            '\033[1;34m%s\033[1;0m]]' % logging.getLevelName(logging.DEBUG))

        logging.addLevelName(
            logging.INFO,
            '\033[1;34m%s\033[1;0m]]' % logging.getLevelName(logging.INFO))

        logging.addLevelName(
            logging.WARNING,
            '\033[1;34m%s\033[1;0m]]' % logging.getLevelName(logging.WARNING))

        logging.addLevelName(
            logging.ERROR,
            '\033[1;34m%s\033[1;0m]]' % logging.getLevelName(logging.ERROR))

        logging.addLevelName(
            logging.CRITICAL,
            '\033[1;34m%s\033[1;0m]]' % logging.getLevelName(logging.CRITICAL))

    def info(self, message: str) -> None:
        """Log info message.
        :param message: Message to log.
        """
        logging.info(message)

    def debug(self, message: str) -> None:
        """Log debug message.
        :param message: Message to log.
        """
        logging.debug(message)

    def warn(self, message: str) -> None:
        """Log warning message.
        :param message: Message to log.
        """
        logging.warning(message)

    def error(self, message: str) -> None:
        """Log error message.
        :param message: Message to log.
        """
        logging.error(message)

    def critical(self, message: str) -> None:
        """Log critical message.
        :param message: Message to log.
        """
        logging.critical(message)

    def exception(self, message: str) -> None:
        """Log exception message with exception info.
        :param message: Message to log.
        """
        logging.exception(message)
