# 产品说明

## 产品介绍

Goodjob-SDK是为了满足国际化翻译，实现了一键配置翻译结果同步到应用上，使开发者在开发过程中不再需要关注于文案的翻译和撰写，能将更大的精力放在研发上。

![图片](https://uploader.shimo.im/f/YumH28VoczjqX4FY.png!thumbnail)

## Demo体验

点击链接下载体验[https://github.com/orth/goodjob_flutter/blob/master/example/app-release.apk](https://github.com/orth/goodjob_flutter/blob/master/example/app-release.apk)

## 功能说明

| 功能点   | 功能说明   | 
|:----|:----|
| 国家语言   | 支持40多重国家语言获取   | 
| 语言切换   | 国际化语言一键切换   | 
| 翻译   | 切换语言自动本地翻译，无需调用网络 | 

## 使用场景

【场景描述】在flutter应用中，要实现国际化，往往需要集成第三方插件，并且在本地创建多个语言多json文件，然后利用插件生成对应的国际化语法文件，同时还需要在项目里添加相关配置。

【使用流程】在网站申请完开发者账号后，就可以创建项目，在后台一目了然的看到所有项目的语言文档翻译，并且支持多人编辑，共享导出等。app端只需要集成sdk，无需关注其它，只需要在后台拿到对应的文本 key ，通过sdk的查询方法即可拿到对应的文本。

# 账号注册及申请

1.登陆 [https://goodjob.ai/](https://goodjob.ai/) 申请成为开发者

2.面板栏选择创建新项目

![图片](https://uploader.shimo.im/f/vSPBAoU7br7HdPwT.png!thumbnail)

3.个人中心查看生成的 apiKey 和 apiSecret.

# SDK-Flutter集成

## 集成方式

1. GitHub 集成

在项目根目录下的pubspec.yaml文件中加入

```plain
dependencies:
 ...
  goodjob_flutter:
	    git:
	      url: git://github.com/orth/goodjob_flutter.git
```
1. 直接下载库

在 [https://github.com/orth/goodjob_flutter](https://github.com/orth/goodjob_flutter) 下载最新版本的库，在项目里导入，并更新依赖

## 文档说明

接口说明文档请参考链接：

## 功能使用

1. 初始化 sdk 
```plain
GoodJobBusiness _business = GoodJobBusiness.getInstance();
var res =  await _business.initSDK(
     apiKey: "goodjob_api_key",
     apiSecret: "goodjob_api_secret",
     id: '10133',
     isDebug: true);
    
```
1. 获取翻译结果

keyName需要和 goodjob 配置的名称一一对应，如需修改请在后台操作，默认中文

```plain
var res = await _business.interpret(keyName);
```
1. 切换语言
```plain
_business.switchLanguage(language: lang);
```
1. 获取已添加语言列表
```plain
_business.getLanguageList();
```
## 其它功能

如果想控制全局状态的变更，建议本地手动导入 provider 库

```plain
dependencies:
  provider: ^4.0.5
```
文档provider官方文档
[https://pub.dev/packages/provider](https://pub.dev/packages/provider)

example以4.0.5为例：

1. 定义 Counter 文件

```plain
class Counter with ChangeNotifier,DiagnosticableTreeMixin{
  String _key10 = "";
  String get key10 => _key10;
  void initCounter({String lang}) async {
    GoodJobBusiness _business = GoodJobBusiness.getInstance();
    if (lang != null) {
      _business.switchLanguage(language: lang);
    }
    _key10 = await _business.interpret("key10");
    notifyListeners();
  }  
}
```
2. 修改 main 中 App 入口

```plain
void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Counter()),
    ],
    child: MyApp(),
  ));
}
```
3. 使用

```plain
Text('${Provider.of<Counter>(context).key10}')
```
