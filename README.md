
# 云笔记个人知识库系统

## 项目简介

云笔记是一个基于 Java Web 技术栈开发的个人知识库管理系统，用于帮助用户记录、管理和分享个人笔记。

## 技术栈

- **语言**: Java 8
- **框架**: JSP + Servlet + JDBC
- **数据库**: MySQL 8.0+
- **服务器**: Tomcat 9
- **构建工具**: Maven

## 项目结构

```
cloud-note/
├── pom.xml                    # Maven 配置文件
├── README.md                  # 项目说明文档
├── sql/
│   └── init.sql              # 数据库初始化脚本
└── src/
    └── main/
        ├── java/
        │   └── com/
        │       └── yunotes/
        │           ├── entity/    # 实体类
        │           ├── dao/       # 数据访问层
        │           ├── service/   # 业务逻辑层
        │           ├── servlet/   # Servlet 控制器
        │           ├── filter/    # 过滤器
        │           └── util/      # 工具类
        └── webapp/
            ├── index.jsp         # 首页
            └── WEB-INF/
                └── web.xml       # Web 配置文件
```

## 环境要求

- JDK 8+
- MySQL 8.0+
- Tomcat 9.x
- Maven 3.6+

## 快速开始

### 1. 创建数据库

```sql
CREATE DATABASE cloud_note DEFAULT CHARACTER SET utf8mb4;
```

### 2. 执行初始化脚本

```bash
mysql -u root -p cloud_note < sql/init.sql
```

### 3. 配置数据库连接

修改 `src/main/java/com/yunotes/util/DBUtil.java` 中的数据库连接信息：

```java
private static final String URL = "jdbc:mysql://localhost:3306/cloud_note?useSSL=false&serverTimezone=UTC&characterEncoding=utf8";
private static final String USERNAME = "your_username";
private static final String PASSWORD = "your_password";
```

### 4. 构建项目

```bash
mvn clean package
```

### 5. 部署运行

将 `target/cloud-note-1.0.0.war` 复制到 Tomcat 的 `webapps` 目录下，启动 Tomcat 即可。

## 访问地址

- 首页: http://localhost:8080/cloud-note/
- 测试 Servlet: http://localhost:8080/cloud-note/test

## 功能模块

- 用户管理（登录、注册、个人信息管理）
- 笔记管理（创建、查看、编辑、删除笔记）
- 分类管理（笔记分类）

## 开发说明

本项目遵循 MVC 架构模式，使用 JDBC 进行数据库操作，不使用任何 ORM 框架。
