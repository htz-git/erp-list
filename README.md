# ERP跨境电商管理系统

基于微服务架构的跨境电商ERP管理系统，参考hmall项目配置。

## 项目结构

```
erp/
├── erp-gateway/          # 网关服务（端口：8080）
├── erp_user/             # 用户服务（端口：8081）
├── erp_order/            # 订单服务（端口：8082）
├── erp_pay/              # 支付服务（端口：8083）
├── erp_promotion/         # 促销服务（端口：8084）
├── erp_purchase/         # 采购服务（端口：8085）
├── erp_refund/           # 退款服务（端口：8086）
├── erp_replenishment/    # 补货服务（端口：8087）
└── erp_common/           # 公共模块
```

## 技术栈

- **Spring Boot**: 3.2.0
- **Spring Cloud**: 2023.0.0
- **Spring Cloud Alibaba**: 2022.0.0.0
- **Nacos**: 服务注册与配置中心
- **Gateway**: 服务网关
- **MyBatis Plus**: 数据库ORM框架
- **MySQL**: 数据库
- **Knife4j**: API文档

## 环境要求

- JDK 11+
- Maven 3.6+
- MySQL 8.0+
- Nacos 2.0+

## 快速开始

### 1. 启动Nacos

```bash
# 下载并启动Nacos
# Windows: startup.cmd -m standalone
# Linux/Mac: sh startup.sh -m standalone
```

访问 http://localhost:8848/nacos，默认用户名/密码：nacos/nacos

### 2. 创建数据库

为每个服务创建对应的数据库：

```sql
CREATE DATABASE erp_user;
CREATE DATABASE erp_order;
CREATE DATABASE erp_pay;
CREATE DATABASE erp_promotion;
CREATE DATABASE erp_purchase;
CREATE DATABASE erp_refund;
CREATE DATABASE erp_replenishment;
```

### 3. 配置数据库连接

修改各服务的 `application.yaml` 文件中的数据库连接信息：
- 数据库地址
- 用户名
- 密码

### 4. 编译项目

```bash
cd E:\erp
mvn clean install
```

### 5. 启动服务

#### 方式一：使用启动脚本（推荐）

**Windows系统：**

```bash
# 启动所有服务
start-all.bat

# 或者单独启动
start-gateway.bat
start-user-service.bat
start-order-service.bat
# ... 其他服务
```

**Linux/Mac系统：**

```bash
# 启动所有服务
./start-all.sh

# 或者单独启动
./start-gateway.sh
./start-user-service.sh
./start-order-service.sh
# ... 其他服务
```

#### 方式二：使用IDE

在IDE中依次启动以下主类：
1. `erp-gateway` -> `GatewayApplication`
2. `erp_user` -> `ErpUserApplication`
3. `erp_order` -> `ErpOrderApplication`
4. `erp_pay` -> `ErpPayApplication`
5. `erp_promotion` -> `ErpPromotionApplication`
6. `erp_purchase` -> `ErpPurchaseApplication`
7. `erp_refund` -> `ErpRefundApplication`
8. `erp_replenishment` -> `ErpReplenishmentApplication`

#### 方式三：使用Maven命令

```bash
# 启动网关
cd erp-gateway
mvn spring-boot:run

# 启动用户服务
cd ../erp_user
mvn spring-boot:run

# ... 其他服务类似
```

## 服务访问地址

- **网关入口**: http://localhost:8080
- **用户服务**: http://localhost:8081
- **订单服务**: http://localhost:8082
- **支付服务**: http://localhost:8083
- **促销服务**: http://localhost:8084
- **采购服务**: http://localhost:8085
- **退款服务**: http://localhost:8086
- **补货服务**: http://localhost:8087

## API文档

各服务启动后，可通过以下地址访问Knife4j API文档：

- 用户服务: http://localhost:8081/doc.html
- 订单服务: http://localhost:8082/doc.html
- 支付服务: http://localhost:8083/doc.html
- 促销服务: http://localhost:8084/doc.html
- 采购服务: http://localhost:8085/doc.html
- 退款服务: http://localhost:8086/doc.html
- 补货服务: http://localhost:8087/doc.html

## 网关路由规则

所有请求通过网关统一入口访问，路由规则如下：

- `/api/users/**` -> `erp-user-service`
- `/api/orders/**` -> `erp-order-service`
- `/api/pays/**` -> `erp-pay-service`
- `/api/promotions/**` -> `erp-promotion-service`
- `/api/purchases/**` -> `erp-purchase-service`
- `/api/refunds/**` -> `erp-refund-service`
- `/api/replenishments/**` -> `erp-replenishment-service`

## 系统入口

### 🎯 一键启动（推荐）

**Windows系统：**
双击运行 `启动系统.bat` 文件，将自动启动所有服务并打开系统入口页面。

**Linux/Mac系统：**
```bash
chmod +x 启动系统.sh
./启动系统.sh
```

### 🌐 系统入口地址

**主入口页面：http://localhost:9000**

这是系统的可视化入口页面，提供：
- 服务状态监控
- 快速访问链接
- 系统使用说明

**网关入口：http://localhost:8080**

所有API请求都应通过网关访问，例如：
- 用户服务：http://localhost:8080/api/users/xxx
- 订单服务：http://localhost:8080/api/orders/xxx

## 注意事项

1. **启动顺序**：建议先启动网关服务，再启动其他业务服务
2. **Nacos配置**：确保Nacos服务正常运行，各服务才能正常注册和发现
3. **数据库配置**：根据实际情况修改各服务的数据库连接信息
4. **端口占用**：确保各服务端口未被占用
5. **日志文件**：各服务的日志文件位于 `logs/{服务名}/` 目录下

## 开发说明

### 添加新服务

1. 在根目录创建新的服务模块
2. 在 `pom.xml` 中添加模块引用
3. 参考现有服务配置 `pom.xml`、`bootstrap.yaml`、`application.yaml`
4. 在网关 `application.yaml` 中添加路由配置

### 服务间调用

使用 OpenFeign 进行服务间调用：

```java
@FeignClient("erp-user-service")
public interface UserClient {
    // 定义接口方法
}
```

## 常见问题

1. **服务无法注册到Nacos**
   - 检查Nacos是否启动
   - 检查 `bootstrap.yaml` 中的Nacos地址配置

2. **服务间调用失败**
   - 检查服务是否已注册到Nacos
   - 检查Feign客户端配置

3. **数据库连接失败**
   - 检查数据库是否启动
   - 检查 `application.yaml` 中的数据库配置

## 许可证

MIT License

