
![goodjob](https://goodjob.ai/img/logo.a4108e28.svg)

[中文](./README_CN.md)

## product description

Goodjob-SDK is to meet the needs of international translation and realize the synchronization of the translation results of one-click configuration to the application, so that developers no longer need to pay attention to the translation and writing of copywriting during the development process, and can put its volume on research and development.

! [Picture] (https://uploader.shimo.im/f/YumH28VoczjqX4FY.png! Thumbnail)

##Demo experience

Click the link to download the experience [https://github.com/orth/goodjob_flutter/blob/master/example/app-release.apk](https://github.com/orth/goodjob_flutter/blob/master/example/app- release.apk)

## Function Description

|Function Points|Function Description|
|: ---- | :: ---- |
|National language|Support more than 40 national language acquisition|
|Language switching|One-click switching of internationalized languages|
|Translation|Switch language automatic local translation without calling the network|

## scenes

[Scene description] In flutter application, to achieve internationalization, it is usually necessary to integrate third-party plug-ins, and create multiple languages ​​and multi-json files locally, and then use plug-ins to generate corresponding internationalized grammar files, and also need to be added to the project Related configuration.

[Usage process] After applying for a developer account on the website, you can create a project, and you can see the language document translation of all projects at a glance in the background, and support multi-person editing, sharing and exporting. The app side only needs to integrate the SDK, no need to pay attention to other things, just get the corresponding text key in the background, and the corresponding text can be obtained through the SDK query method.

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
