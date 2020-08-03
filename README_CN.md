![goodjob](https://goodjob.ai/img/logo.a4108e28.svg)

[English](./README.md)

# 账号注册及申请

1.登陆 [https://goodjob.ai/](https://goodjob.ai/) 申请成为开发者

2.面板栏选择创建新项目

![goodjob](https://github.com/goodjob-ai/goodjob-flutter/blob/master/goodjob-CH.png)

3.个人中心查看生成的 apiKey 和 apiSecret.

# SDK-Flutter集成

## 集成方式

```
dependencies:
  goodjob_language: ^latest_version

```

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
2. 获取翻译结果

keyName需要和 goodjob 配置的名称一一对应，如需修改请在后台操作，默认中文

```plain
var res = await _business.interpret(keyName);
```
切换语言
```plain
_business.switchLanguage(language: lang);
```
获取已添加语言列表
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
