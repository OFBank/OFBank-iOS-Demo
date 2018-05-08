## iOS SDK配置

### 1.创建应用

到ofbank开放平台创建应用，应用创建完成后，进入应用模块进行设置，具体操作请参见[创建APP](www.ofbank.com)。

### 2.SDK下载和集成

##### 2.1手动集成

###### 2.1.1控制台下载

  - 在开放平台SDK下载页进行下载；
  ![](http://file.lingzhuworld.cn:80/group1/M00/00/10/rBEW81riltGAQ5sUAAQbAy3Byfg948.jpg 'download')

###### 2.1.2公共依赖包

 - SystemConfiguration.framework

###### 2.1.3SDK目录结构
 
 - OFMiningSDK.framework

###### 2.1.4引入framework

 - Xcode中，直接把下载SDK目录中的framework拖入对应Target下即可，在弹出框勾选`Copy items if needed`;
 - 在`Build Phases -> Link Binary With Libraries`中，引入2.1.2列出的公共包.

##### 2.2Pod依赖

  - 指定Master仓库和ofbank仓库

	```
	source 'https://github.com/CocoaPods/Specs.git'
	source 'https://github.com/OFBank/ofbank-specs.git'
	```
	
  - 添加依赖：
   
    ```
    pod 'OFMiningSDK'
    ```

### 3.SDK使用说明

 - 工程引入头文件
 
   ```
   #import <OFMiningSDK/OFMiningSDK.h>
   ```
   
 - 请参照以下代码完成SDK的初始化，appKey/appSecret 的获取参考[创建App](www.ofbank.com)
 
 ``` Objective-C
 // SDK初始化
 [OFMiningSDK startWithAppCode:@"your app id" security:@"your app secret"];
 
 // 打开调试日志
 [OFMiningSDK turnOnDebug];
 
 ```
