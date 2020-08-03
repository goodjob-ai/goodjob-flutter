
![goodjob](https://goodjob.ai/img/logo.a4108e28.svg)

[中文](./README_CN.md)

# Account registration

1.Please log in [https://goodjob.ai/](https://goodjob.ai/) apply to be a developer

2.The panel bar choose to create a new project

![goodjob](https://github.com/goodjob-ai/goodjob-flutter/blob/master/goodjob.png?raw=true)

3.View the generated apiKey and apiSecret personal center.

# SDK-Flutter

## Method

```
dependencies:
  goodjob_language: ^latest_version

```

## Use

1. init sdk 
```plain
GoodJobBusiness _business = GoodJobBusiness.getInstance();
var res =  await _business.initSDK(
     apiKey: "goodjob_api_key",
     apiSecret: "goodjob_api_secret",
     id: '10133',
     isDebug: true);
    
```
2. Get results for translation

KeyName needs and goodjob configuration with the name of the one to one correspondence, 
such as the need to modify please operate in the background, Chinese by default

```plain
var res = await _business.interpret(keyName);
```
Switch language
```plain
_business.switchLanguage(language: lang);
```
To obtain a list has added languages
```plain
_business.getLanguageList();
```
## More

If you want to control the state of the global change, 
it is suggested that local manually import the provider library
```plain
dependencies:
  provider: ^4.0.5
```
[Provider document](https://pub.dev/packages/provider)

In order to 4.0.5 As an example：

1. define Counter 

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
2. Modify the App in the main entrance

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
3. use

```plain
Text('${Provider.of<Counter>(context).key10}')
```
