# Note: 使用前，先检查.env配置是否正确。
# 主要针对的数据存储的路径。比如 pg、redis等。

include .env

build_base:
	docker build -t ${PROJECT_NAME}_for_rails .

# 单独部署web api应用
run_api:
	docker run -d \
		--restart always \
		-e RAILS_ENV=production \
		-p 3000:3000 \
		-v ${PROJECT_PATH}/.env:/project_api/.env \
    -v ${PROJECT_PATH}/log:/project_api/log \
    -v ${PROJECT_PATH}/tmp:/project_api/tmp \
    -v ${PROJECT_PATH}/public/assets:/project_api/public/assets \
    -v ${PROJECT_PATH}/public/uploads:/project_api/public/uploads \
		--name ${PROJECT_NAME}_api \
		${PROJECT_NAME}_for_rails \
		sh shell/deploy_api.sh

# 单独部署数据库
run_pg:
	docker run -d \
		--restart always \
		-e POSTGRES_USER=${DATABASE_USER_NAME} \
		-e POSTGRES_PASSWORD=${DATABASE_PASSWORD} \
		-e PGDATA=/var/lib/postgresql/data/pgdata \
		-v ${PROJECT_DB_PATH}:/var/lib/postgresql/data/pgdata \
		-p ${DATABASE_PORT}:5432 \
		--name ${PROJECT_NAME}_pg \
		postgres:10.3 \
		postgres

# 单独部署redis
run_redis:
	docker run -d \
		--rm \
		-v ${PROJECT_REDIS_PATH}/data:/data \
		-p ${REDIS_PORT}:6379 \
		--name ${PROJECT_NAME}_redis \
		redis \
		redis-server --appendonly yes --requirepass ${REDIS_PWD}
