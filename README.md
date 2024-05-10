# Testcontainers

## 什么是Testcontainers
1. Testcontainers 是一个用于在测试过程中管理容器的 Java 库。它提供简单且轻量级的 API，用于通过 Docker 容器中包装的真实服务引导本地开发和测试依赖项。使用测试容器，您可以编写依赖于生产中使用的相同服务的测试，而无需模拟或内存中服务。
2. 它允许在的单元测试、集成测试或端到端测试中使用容器化的服务，如数据库、消息代理、Web 服务器等。通过 Testcontainers，可以方便地在测试中启动、停止和配置容器，并且可以确保测试环境与实际生产环境尽可能一致。
3. 它的设计初衷是为了在开发人员的本地开发环境中提供容器化的集成测试环境，以便他们可以在本地开发过程中更轻松地编写和运行集成测试。
## 开发常见问题：
1. 环境准备：假如开发某个服务，测试时需要先配置依赖的数据库、redis、消息队列等服务
2. 测试数据隔离：我们并行运行测试，多个测试之间的业务状态可能会相互影响。
3. 依赖管理： 测试环境可能需要依赖外部资源，如数据库、消息队列等，需要手动配置这些依赖，比如trade服务需要启动一个rabbitmq服务,那每个开发人都需要配置这些依赖，这会增加开发成本，影响开发效率。

## 主要功能:
1. 动态启动容器：Testcontainers 允许用户通过代码动态启动 Docker 容器，而无需手动设置或管理容器实例。
2. 支持多种容器：Testcontainers 支持多种常见的 Docker 容器，例如 Redis、MySQL、RabbitMQ、PostgreSQL、MongoDB 等，同时也支持自定义容器。
3. 生命周期管理：Testcontainers 管理容器的生命周期，确保在测试运行结束后自动停止和清理容器。
4. 可与测试框架集成：Testcontainers 可以与JUnit、TestNG 等测试框架无缝集成，使得在测试中使用容器变得更加简单。

## Testcontainers必要条件：

1.Docker
mac安装docker
```
brew install --cask docker
```

2. 导入依赖
```
   <dependency>
       <groupId>org.testcontainers</groupId>
       <artifactId>testcontainers</artifactId>
       <version>1.19.8</version>
       <scope>test</scope>
   </dependency>
```
3. testcontainers支持多种常见的 Docker 容器，例如 Redis、MySQL、RabbitMQ、PostgreSQL、MongoDB 等，同时也支持自定义容器：
如需使用RabbitMQ容器，引入对应的依赖即可：
```
   <dependency>
       <groupId>org.testcontainers</groupId>
       <artifactId>rabbitmq</artifactId>
       <version>1.19.8</version>
       <scope>test</scope>
   </dependency>
```
4. 创建并启动rabbitmq容器：
```
    //创建rabbitmq容器
   RabbitMQContainer container = new RabbitMQContainer("rabbitmq:3.7.25-management-alpine")

   //启动容器
   container.start();
```
5. 创建队列
```
    //创建队列
   container.withQueue("queueOne");
     //断言队列是否存在
   assertThat(container.execInContainer("rabbitmqctl", "list_queues", "name", "arguments").getStdout())
                .containsPattern("queue-one");
```
## Testcontainers 使用场景：
1. 数据库集成测试：通过在测试中启动数据库容器，可以执行与数据库交互的集成测试，而无需在本地安装和配置数据库。
2. 消息队列测试：您可以使用 Testcontainers 启动消息代理容器（如 Kafka 或 RabbitMQ），以测试应用程序与消息队列的交互。
3. 第三方服务测试：如果您的应用程序依赖于外部服务（如 Redis、Elasticsearch 等），您可以使用 Testcontainers 启动相应的容器以进行测试。
4. 集成测试：在开发过程中，可能需要编写一些集成测试，用于测试应用程序与外部依赖（如数据库、消息队列、外部服务等）的交互。使用 Testcontainers，可以在测试期间启动这些外部依赖的容器，以便进行真实的集成测试。
5. 本地开发环境：有时候，在本地开发环境中模拟真实的生产环境可能比较困难，特别是涉及到外部依赖的情况。在这种情况下，可以使用 Testcontainers 来在本地开发环境中启动容器，以模拟生产环境中的外部依赖，从而更容易地进行开发和调试。
6. 构建和持续集成：在构建和持续集成过程中，可能需要运行一些集成测试，以确保应用程序在不同环境下的行为一致性。使用 Testcontainers，可以在构建和持续集成过程中启动容器，并运行这些集成测试，以确保应用程序在不同环境下的正常运行。
7. 依赖管理：有时候，的应用程序可能依赖于一些外部服务或者组件，而这些服务或者组件可能不适合在本地开发环境中直接运行。使用 Testcontainers，可以将这些外部依赖封装在容器中，并在需要时启动这些容器，从而简化依赖管理的过程。


## Testcontainers的主要特点和优势：
1. 简单易用： Testcontainers 提供了一个简单的 API，易于集成到的测试代码中。它使用类似于 JUnit 的注解和断言，使得容器管理变得简单而直观。
2. 灵活性： Testcontainers 支持各种常见的容器技术，包括 Docker 和 Kubernetes。可以使用已经存在的容器镜像，也可以通过 Dockerfile 来自定义镜像。
3. 自动化： Testcontainers 能够自动处理容器的启动、停止和清理，这样就不必手动管理容器的生命周期。它能够确保测试的环境始终保持一致和可重复。
4. 与测试框架集成： Testcontainers 可以与主流的 Java 测试框架（如 JUnit、TestNG）以及其他测试库（如 Spring Boot Test）无缝集成，使得在不同测试场景中使用容器变得更加方便。
5. 支持多种场景： 无论是单元测试、集成测试还是端到端测试，Testcontainers 都能够满足的需求。可以在测试中使用容器化的数据库、消息队列、缓存等，以及模拟复杂的分布式系统环境。


## 测试流程：
测试前：
使用 Testcontainers API 启动所需的服务（数据库、消息系统等）docker 容器。
配置或更新应用程序配置以使用这些容器化服务。

测试期间：
测试将使用这些容器化服务运行。

测试后：
测试容器将负责销毁这些容器，无论测试是否成功执行或有任何测试失败。
## 总结：
### 优点：
隔离性和一致性： Testcontainers 提供了隔离的测试环境，每个测试用例都在独立的容器中运行，避免了测试数据的污染和相互影响。这确保了测试的一致性和可靠性。
支持多种容器： Testcontainers 支持多种常见的容器，包括 MySQL、PostgreSQL、MongoDB、Redis 等，以及自定义的 Docker 镜像。这使得您可以针对不同的应用场景创建不同类型的测试环境。
集成方便： Testcontainers 可以与JUnit、TestNG等测试框架和构建工具（如 Maven、Gradle）无缝集成，方便地与现有的测试代码和工作流程结合使用。
### 缺点：
学习曲线： 使用 Docker 和 Testcontainers 可能需要一些额外的学习和理解。尤其是对于那些对容器化技术不熟悉的开发者来说，他们可能需要花费一些时间来学习 Docker 的基础知识和 Testcontainers 的使用方法。
性能开销： 在某些情况下，启动和管理 Docker 容器会带来一定的性能开销，特别是在大型测试套件中。这可能会导致测试运行时间的增加，尤其是在需要频繁启动和停止容器的情况下。
依赖 Docker： Testcontainers 需要依赖 Docker 引擎来创建和管理容器，因此需要确保开发环境中安装了 Docker，并且 Docker 守护进程正在运行。这对于一些开发者可能会带来额外的配置和管理负担。
资源消耗： 启动和运行 Docker 容器可能会消耗大量的系统资源，包括内存、CPU 和磁盘空间。在某些情况下，这可能会对开发环境的性能和稳定性产生影响。
网络配置复杂： 在某些情况下，需要额外的网络配置才能确保 Testcontainers 创建的容器与其他服务或数据库正确通信。特别是在跨容器通信或与本地服务通信时，可能需要更多的配置和调试。


 Testcontainers 的优势在于能够提供一致的环境，从而确保测试结果的可靠性和一致性。它也有一些缺点，如学习曲线、性能开销、依赖 Docker 和资源消耗等。


