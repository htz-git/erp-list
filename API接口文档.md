# ERP跨境电商管理系统 - API接口文档

## 一、用户服务接口（erp-user-service）

### 基础路径
- 直接访问：`http://localhost:8081`
- 通过网关：`http://localhost:8080/api/users`

### 1. 创建用户
- **接口**：`POST /users`
- **描述**：创建新用户
- **请求体**：
```json
{
  "username": "testuser",
  "password": "123456",
  "realName": "测试用户",
  "phone": "13800138000",
  "email": "test@example.com",
  "status": 1
}
```
- **响应**：
```json
{
  "code": 200,
  "message": "操作成功",
  "data": {
    "id": 1,
    "username": "testuser",
    "realName": "测试用户",
    "phone": "13800138000",
    "email": "test@example.com",
    "status": 1,
    "createTime": "2025-12-20T10:00:00"
  }
}
```

### 2. 根据ID查询用户
- **接口**：`GET /users/{id}`
- **描述**：根据用户ID查询用户信息
- **路径参数**：`id` - 用户ID
- **响应**：用户信息对象

### 3. 更新用户
- **接口**：`PUT /users/{id}`
- **描述**：更新用户信息
- **路径参数**：`id` - 用户ID
- **请求体**：用户DTO（不包含密码和用户名）

### 4. 删除用户
- **接口**：`DELETE /users/{id}`
- **描述**：删除用户（逻辑删除）
- **路径参数**：`id` - 用户ID

### 5. 分页查询用户
- **接口**：`GET /users`
- **描述**：分页查询用户列表
- **查询参数**：
  - `username` - 用户名（模糊查询）
  - `phone` - 手机号（精确查询）
  - `email` - 邮箱（模糊查询）
  - `status` - 状态（0-禁用，1-启用）
  - `pageNum` - 页码（默认1）
  - `pageSize` - 每页大小（默认10）
- **示例**：`GET /users?username=test&status=1&pageNum=1&pageSize=10`

### 6. 启用/禁用用户
- **接口**：`PUT /users/{id}/status`
- **描述**：启用或禁用用户
- **路径参数**：`id` - 用户ID
- **查询参数**：`status` - 状态（0-禁用，1-启用）

## 二、订单服务接口（erp-order-service）

### 基础路径
- 直接访问：`http://localhost:8082`
- 通过网关：`http://localhost:8080/api/orders`

### 1. 创建订单
- **接口**：`POST /orders`
- **描述**：创建新订单
- **请求体**：
```json
{
  "userId": 1,
  "items": [
    {
      "productId": 1001,
      "productName": "商品名称",
      "skuId": 2001,
      "skuCode": "SKU001",
      "price": 99.00,
      "quantity": 2
    }
  ],
  "discountAmount": 10.00,
  "receiverName": "张三",
  "receiverPhone": "13800138000",
  "receiverAddress": "北京市朝阳区xxx",
  "remark": "请尽快发货"
}
```
- **响应**：订单对象（包含订单号、总金额、实付金额等）

### 2. 根据ID查询订单
- **接口**：`GET /orders/{id}`
- **描述**：根据订单ID查询订单详情
- **路径参数**：`id` - 订单ID

### 3. 根据订单号查询订单
- **接口**：`GET /orders/orderNo/{orderNo}`
- **描述**：根据订单号查询订单
- **路径参数**：`orderNo` - 订单号

### 4. 更新订单状态
- **接口**：`PUT /orders/{id}/status`
- **描述**：更新订单状态
- **路径参数**：`id` - 订单ID
- **查询参数**：`status` - 订单状态
  - 0 - 待支付
  - 1 - 已支付
  - 2 - 已发货
  - 3 - 已完成
  - 4 - 已取消
  - 5 - 已退款

### 5. 更新支付状态
- **接口**：`PUT /orders/{id}/payStatus`
- **描述**：更新订单支付状态
- **路径参数**：`id` - 订单ID
- **查询参数**：`payStatus` - 支付状态
  - 0 - 未支付
  - 1 - 已支付
  - 2 - 已退款

### 6. 取消订单
- **接口**：`PUT /orders/{id}/cancel`
- **描述**：取消订单（只有待支付和已支付的订单可以取消）
- **路径参数**：`id` - 订单ID

### 7. 分页查询订单
- **接口**：`GET /orders`
- **描述**：分页查询订单列表
- **查询参数**：
  - `orderNo` - 订单号
  - `userId` - 用户ID
  - `orderStatus` - 订单状态
  - `payStatus` - 支付状态
  - `pageNum` - 页码（默认1）
  - `pageSize` - 每页大小（默认10）

### 8. 查询订单明细
- **接口**：`GET /order-items/order/{orderId}`
- **描述**：根据订单ID查询订单明细
- **路径参数**：`orderId` - 订单ID

- **接口**：`GET /order-items/orderNo/{orderNo}`
- **描述**：根据订单号查询订单明细
- **路径参数**：`orderNo` - 订单号

## 三、统一响应格式

所有接口统一使用以下响应格式：

```json
{
  "code": 200,
  "message": "操作成功",
  "data": {}
}
```

- `code`：状态码（200-成功，400-参数错误，500-服务器错误）
- `message`：提示信息
- `data`：响应数据

## 四、错误响应示例

```json
{
  "code": 500,
  "message": "用户名已存在",
  "data": null
}
```

## 五、接口测试示例

### 使用Postman测试

1. **创建用户**
   - Method: POST
   - URL: http://localhost:8080/api/users
   - Body (JSON):
   ```json
   {
     "username": "testuser",
     "password": "123456",
     "realName": "测试用户",
     "phone": "13800138000",
     "email": "test@example.com"
   }
   ```

2. **创建订单**
   - Method: POST
   - URL: http://localhost:8080/api/orders
   - Body (JSON):
   ```json
   {
     "userId": 1,
     "items": [
       {
         "productId": 1001,
         "productName": "测试商品",
         "price": 99.00,
         "quantity": 1
       }
     ],
     "receiverName": "张三",
     "receiverPhone": "13800138000",
     "receiverAddress": "北京市朝阳区"
   }
   ```

3. **查询订单列表**
   - Method: GET
   - URL: http://localhost:8080/api/orders?userId=1&pageNum=1&pageSize=10

## 六、API文档访问

各服务启动后，可通过以下地址访问Knife4j API文档：

- 用户服务：http://localhost:8081/doc.html
- 订单服务：http://localhost:8082/doc.html

文档中包含完整的接口说明、参数说明和示例。

