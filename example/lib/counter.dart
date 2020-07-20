import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:goodjob_flutter/goodjob_flutter.dart';

class Counter with ChangeNotifier, DiagnosticableTreeMixin {
  String _key10 = "";

  String get key10 => _key10;
  String _key1 = "";

  String get key1 => _key1;
  String _key0 = "";

  String get key0 => _key0;

  String _key3 = "";

  String get key3 => _key3;
  String _key2 = "";

  String _key4 = "";

  String _key5 = "";

  String _key6 = "";

  String _key7 = "";

  String _key8 = "";

  String _key9 = "";

  String _key11 = "";

  String _key12 = "";

  String _key13 = "";

  String _key14 = "";

  String _key15 = "";
  String _key16 = "";



  String get key2 => _key2;
  int _count = 0;

  get count => _count; //3
  //在这里初始化所有(切换语言后必须调用)
  void initCounter({String lang}) async {
    GoodJobBusiness _business = GoodJobBusiness.getInstance();
    if (lang != null) {
      _business.switchLanguage(language: lang);
    }
    _key10 = await _business.interpret("g_key_10");
    _key0 = await _business.interpret("g_key_15");
    _key1 = await _business.interpret("g_key_1");
    _key3 = await _business.interpret("g_key_2");
    _key2 = await _business.interpret("g_key_3");
    _key4 = await _business.interpret("g_key_4");
    _key5 = await _business.interpret("g_key_5");
    _key6 = await _business.interpret("g_key_6");
    _key7 = await _business.interpret("g_key_7");
    _key8 = await _business.interpret("g_key_8");
    _key9 = await _business.interpret("g_key_9");
    _key11 = await _business.interpret("g_key_11");
    _key12 = await _business.interpret("g_key_12");
    _key13 = await _business.interpret("g_key_13");
    _key14 = await _business.interpret("g_key_14");

    notifyListeners();
  }

  void add() {
    _count++;
    notifyListeners(); //2
  }

  String get key4 => _key4;

  String get key5 => _key5;

  String get key6 => _key6;

  String get key16 => _key16;

  String get key15 => _key15;

  String get key14 => _key14;

  String get key13 => _key13;

  String get key12 => _key12;

  String get key11 => _key11;

  String get key9 => _key9;

  String get key8 => _key8;

  String get key7 => _key7;


/// Makes `Counter` readable inside the devtools by listing all of its properties
//  @override
//  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//    super.debugFillProperties(properties);
//    properties.add(IntProperty('count', count));
//    properties.add(StringProperty('key0', key0));
//  }
}
