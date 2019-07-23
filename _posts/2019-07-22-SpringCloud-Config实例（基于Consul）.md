### 基于 Consul 的分布式配置中心（Spring Cloud Config）实例

#### 开发环境及工具
- JDK 1.8
- Maven 3
- SpringBoot 2.0
- SpringCloud Finchley.M7
- Consul
- Eclipse

#### 准备：创建 Maven 父项目 negen-demo-parent
- 配置 pom.xml 引入相关依赖
```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.negen</groupId>
  <artifactId>negen-demo-parent</artifactId>
  <version>0.0.1-SNAPSHOT</version>
  <packaging>pom</packaging>

	<!-- SpringBoot依赖 -->
	<parent>
		<groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-starter-parent</artifactId>
		<version>2.0.1.RELEASE</version>
	</parent>
	<!-- 管理依赖 -->
	<dependencyManagement>
		<dependencies>
			<dependency>
				<groupId>org.springframework.cloud</groupId>
				<artifactId>spring-cloud-dependencies</artifactId>
				<version>Finchley.M7</version>
				<type>pom</type>
				<scope>import</scope>
			</dependency>
		</dependencies>
	</dependencyManagement>
	<dependencies>
		<!-- SpringBoot整合Web组件 -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-web</artifactId>
		</dependency>
		<dependency>
		    <groupId>org.springframework.cloud</groupId>
		    <artifactId>spring-cloud-context</artifactId>
		</dependency>

		<!-- 健康检查 -->
		<dependency>
		 <groupId>org.springframework.boot</groupId>
		 <artifactId>spring-boot-starter-actuator</artifactId>
		</dependency>

		<!-- SpringBoot整合fegnin客户端 -->
		<dependency>
			<groupId>org.springframework.cloud</groupId>
			<artifactId>spring-cloud-starter-openfeign</artifactId>
		</dependency>
		<!-- lombok 依赖 -->
		<dependency>
			<groupId>org.projectlombok</groupId>
			<artifactId>lombok</artifactId>
		</dependency>
		<!-- hystrix断路器 -->
		<dependency>
			<groupId>org.springframework.cloud</groupId>
			<artifactId>spring-cloud-starter-netflix-hystrix</artifactId>
		</dependency>
		<!-- eureka/consul二选一且配置文件不同 -->
		<!-- SpringBoot整合eureka客户端 -->
<!-- 		<dependency>
			<groupId>org.springframework.cloud</groupId>
			<artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
		</dependency> -->
		<!-- consul依赖 -->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-consul-discovery</artifactId>
        </dependency>
	</dependencies>
	<!-- 注意： 这里必须要添加， 否者各种依赖有问题 -->
	<repositories>
		<repository>
			<id>spring-milestones</id>
			<name>Spring Milestones</name>
			<url>https://repo.spring.io/libs-milestone</url>
			<snapshots>
				<enabled>false</enabled>
			</snapshots>
		</repository>
	</repositories>
<modules>
	<module>config-server</module>
	<module>config-client</module>
</modules>
</project>
```
- 启动 Consul ,windows中启动命令如下：
```bash
consul agent -dev
```

#### 一、创建配置服务中心 config-server
###### 1、创建一个空的 Maven module
###### 2、引入相关的 pom 依赖
```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <parent>
    <groupId>com.negen</groupId>
    <artifactId>negen-demo-parent</artifactId>
    <version>0.0.1-SNAPSHOT</version>
  </parent>
  <artifactId>config-server</artifactId>
  <packaging>war</packaging>

  <dependencies>
  	<!-- cloud-config-server依赖 -->
	<dependency>
	    <groupId>org.springframework.cloud</groupId>
	    <artifactId>spring-cloud-config-server</artifactId>
	</dependency>
  </dependencies>
</project>
```
###### 3、创建启动文件 AppConfigServer.java
```java
package com.negen;


import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.config.server.EnableConfigServer;

@SpringBootApplication
@EnableDiscoveryClient
@EnableConfigServer
public class AppConfigServer {
	public static void main(String[] args) {
		SpringApplication.run(AppConfigServer.class, args);
	}
}
```
###### 4、创建启动配置文件 application.yml
- git.uri：用于存储配置文件的仓库地址
- 重点配置：git.uri

```yml
spring:
  application:
    name: config-server

  cloud:
    consul:
      host: 127.0.0.1     #consul地址
      port: 8500          #consul端口号
    config:
      server:
        git:              #配置文件 git 地址
          uri: https://github.com/BBBBigFlyPig/SpringConfigServer-Configs.git
```
###### 5、git仓库中创建 cloud-config-dev.yml 文件并添加以下内容
```yml
age: 300
name: test
server:
  port: 8888
```
###### 6、启动 AppConfigServer.java 并在浏览器中访问 http://localhost:8080/cloud-config-dev.yml
效果图如下：
![运行结果.png](https://upload-images.jianshu.io/upload_images/16432686-205ff4ddea156d34.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

至此，server端创建完成

#### 一、创建客户端 config-client
###### 1、创建一个空的 Maven module
###### 2、引入相关的 pom 依赖
```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
	<modelVersion>4.0.0</modelVersion>
	<parent>
		<groupId>com.negen</groupId>
		<artifactId>negen-demo-parent</artifactId>
		<version>0.0.1-SNAPSHOT</version>
	</parent>
	<artifactId>config-client</artifactId>
	<packaging>war</packaging>

	<dependencies>
		<!-- cloud-config 客户端依赖 -->
		<dependency>
			<groupId>org.springframework.cloud</groupId>
			<artifactId>spring-cloud-starter-config</artifactId>
		</dependency>

	</dependencies>
</project>
```
###### 3、resource 目录下创建 bootstrap.yml 文件
```yml
server:
  port: 8000
spring:
  application:
    name: cloud-config

  cloud:
    consul:
      host: 127.0.0.1
      port: 8500

    config:
      profile: dev          #选择获取的配置文件是dev还是 test之内的；git仓库配置文件命名格式  ${applicatio.name}-dev/test.yml
      discovery:
        enabled: true
        service-id: config-server    #config服务器的 ${applicatio.name}

management:
  endpoints:
    web:
      exposure:
        include: refresh,health  #暴露手动刷新接口
```
###### 4、创建启动文件 AppConfigClient.java
```java
package com.negen;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@SpringBootApplication
@EnableDiscoveryClient
public class AppConfigClient {
	public static void main(String[] args) {
		SpringApplication.run(AppConfigClient.class, args);
	}
}
```
###### 5、创建测试类 TestConfigServerController.java
```java
package com.negen.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RefreshScope   //在需要刷新配置的地方使用
public class TestConfigServerController {
	@Value("${age}")
	String age;
	@RequestMapping(value = "/getAge")
	public String getAge() {
		return age;
	}
}
```
###### 6、启动应用并用浏览器访问 http://localhost:8888/getAge
应用会优先加载从配置中心拉取到的配置，所以访问的端口就是8888；  


###### 7、手动刷新配置信息
用 Post 方式访问 http://localhost:8888/actuator/refresh 即可获取最新的配置信息；
