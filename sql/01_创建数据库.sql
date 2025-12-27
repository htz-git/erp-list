-- ============================================================
-- ERP跨境电商管理系统 - 数据库创建脚本
-- ============================================================

-- 创建用户服务数据库
CREATE DATABASE IF NOT EXISTS `erp_user` 
DEFAULT CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- 创建订单服务数据库
CREATE DATABASE IF NOT EXISTS `erp_order` 
DEFAULT CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- 创建支付服务数据库
CREATE DATABASE IF NOT EXISTS `erp_pay` 
DEFAULT CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- 创建促销服务数据库
CREATE DATABASE IF NOT EXISTS `erp_promotion` 
DEFAULT CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- 创建采购服务数据库
CREATE DATABASE IF NOT EXISTS `erp_purchase` 
DEFAULT CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- 创建退款服务数据库
CREATE DATABASE IF NOT EXISTS `erp_refund` 
DEFAULT CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- 创建补货服务数据库
CREATE DATABASE IF NOT EXISTS `erp_replenishment` 
DEFAULT CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- 使用数据库
USE `erp_user`;

