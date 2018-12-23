
redis = Redis.new(
  host: ENV['REDIS_HOST'],
  port: ENV['REDIS_PORT'],
  password: ENV['REDIS_PWD'],
  db: 6
)

$cache_client = Redis::Namespace.new('iron_alloy_cache', redis: redis)
