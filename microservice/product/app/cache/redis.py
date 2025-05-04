from app.core.logger import Logger
from redis.asyncio import Redis as RedisClient
from app.constant.constant import CACHE_TTL_SECOND
from redis.typing import ResponseT
from redis.asyncio import from_url, Redis as RedisClient


class Redis:

    def __init__(self, redis_url: str, logger: Logger):
        self.logger = logger
        self.enabled: bool = False
        self.redis_client: RedisClient | None = None
        try:
            self.redis_client = from_url(redis_url, decode_responses=True)
            self.redis_client.ping()
            self.enabled = True
            self.logger.info("Redis connection established successfully.")
        except Exception as e:
            self.logger.error(
                f"Redis was disabled because of connection failure: {e}")

    async def get_value(self, key: str) -> ResponseT | None:
        if self.enabled:
            try:
                value = await self.redis_client.get(key)
                return value
            except Exception as e:
                self.logger.error(f"Error getting value from Redis: {e}")
        return None

    async def set_value(self, key: str, value: str) -> bool:
        if self.enabled:
            try:
                await self.redis_client.set(key, value, ex=CACHE_TTL_SECOND)
                return True
            except Exception as e:
                self.logger.error(f"Error setting value in Redis: {e}")
        return False

    async def exists(self, key: str) -> bool:
        if self.enabled:
            try:
                exists = await self.redis_client.exists(key)
                return exists
            except Exception as e:
                self.logger.error(f"Error checking existence in Redis: {e}")
        return False
