# 使用 Node.js 20 作为基础镜像
FROM node:20

# 设置时区
ENV TIME_ZONE=Asia/Shanghai
ENV TZ=Asia/Shanghai

# 工作目录为 /app
WORKDIR /app

# 将当前目录的内容复制到 /app
COPY . /app/

# 安装依赖并编译应用程序
RUN yarn install && yarn build

# 进入 tracker 目录
WORKDIR /app/packages/tracker

# 再次安装 tracker 模块的依赖并编译
RUN yarn install && yarn build

# 暴露 3000 端口，供 API 或 Worker 访问
EXPOSE 3000

# 添加数据库迁移命令
RUN yarn migration:run

# 默认启动 worker 的生产环境
CMD ["yarn", "start:worker:prod"]

