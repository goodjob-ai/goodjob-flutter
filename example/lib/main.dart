import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:goodjob_language/goodjob_language.dart';
import 'package:provider/provider.dart';

import 'SecondPage.dart';
import 'counter.dart';

String rootPath = '';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Counter()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
//      localizationsDelegates: context.localizationDelegates,
//      supportedLocales: context.supportedLocales,
//      locale: context.locale,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GoodJobBusiness _business;
  String textView = '';
  String title = "";

//  List<LanguageEntity> listLanguage = new List();
  @override
  void initState() {
    super.initState();
    _business = GoodJobBusiness.getInstance();
    //获取国家、语言列表
    _business.getLanguageList();

    _requestPermission();
  }

  ///初始化sdk
  _requestPermission() async {
   var res =  await _business.initSDK(
        apiKey: "66f27cfb-bf47-4b6a-971f-2df147cebbfb",
        apiSecret: "f03ebe480ea8dae2ca441894b8875c19",
        id: '10908',
        isDebug: true);
   //设置默认语言
    Provider.of<Counter>(context, listen: false).initCounter(lang: "en");
  }


  Widget locali() {
    return Column(
      children: <Widget>[Text('context.locale.toString()')],
    );
  }

  ///语言选择
  _showPopup() async {
    var v = await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(300.0, 60.0, 0.0, 10.0),
        items: [
          PopupMenuItem(
            child: Text('简体中文'),
            value: "zhCN",
          ),
          PopupMenuItem(
            child: Text('繁体中文'),
            value: "zhTW",
          ),
          PopupMenuItem(
            child: Text('English'),
            value: "en",
          ),
          PopupMenuItem(
            child: Text('阿拉伯语'),
            value: "ar",
          ),
          PopupMenuItem(
            child: Text('俄语'),
            value: "ru",
          ),
          PopupMenuItem(
            child: Text('韩语'),
            value: "ko",
          ),
        ]);
    Provider.of<Counter>(context, listen: false).initCounter(lang: v.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${Provider.of<Counter>(context).key0}"),
        actions: <Widget>[
          InkWell(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Text('切换语言' + _business.getLanguage()),
            ),
            onTap: () {
              _showPopup();
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Text('status'),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
//                Count(),
//                Text('${Provider.of<Counter>(context).key0}'),
//                Text('${Provider.of<Counter>(context).key1}'),
//                Text('${Provider.of<Counter>(context).key10}'),
//                Text('${Provider.of<Counter>(context).key3}'),
//                Text('${Provider.of<Counter>(context).key2}'),
//                Text('${Provider.of<Counter>(context).key4}'),
//                Text('${Provider.of<Counter>(context).key5}'),
//                Text('${Provider.of<Counter>(context).key6}'),
                //Consumer的<Counter>指定builder中counter参数应是Counter类型，所以实际传入的就
                //是的实例。由于使用了Consumer，那么当值变化时只会重绘Consumer中的部件（这里是
                //Text）。相反如果使用的是Provider.of，那么默认就会重绘ChangeNotifierProvider中
                //child指定的整个MyHomePage部件树。
                Consumer<Counter>(builder: (context, counter, child) {
                  return Column(
                    children: <Widget>[
                      Text('${counter.key0}'),
                      Text('${counter.key1}'),
                      Text('${counter.key10}'),
                      Text('${counter.key3}'),
                      Text('${counter.key2}'),
                      Text('${counter.key4}'),
                      Text('${counter.key5}'),
                      Text('${counter.key6}'),
                      Text('${counter.key7}'),
                      Text('${counter.key8}'),
                      Text('${counter.key9}'),
                      Text('${counter.key11}'),
                      Text('${counter.key12}'),
                      Text('${counter.key13}'),
                    ],
                  );
                }),
                Text('${Provider.of<Counter>(context).count}'),
                FlatButton(
                  child: Text("下一页"),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SecondPage();
                  })),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
