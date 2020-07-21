///日志工具
class LogUtil {
  /// common_utils
  static const String _TAG_DEF = "###common_utils###";

  /// 是否是debug模式,true: log v 不输出.
  static bool debuggable = false;

  /// tag
  static String _mTAG = _TAG_DEF;

  /// init
  static void init({bool isDebug = false, String tag = _TAG_DEF}) {
    debuggable = isDebug;
    _mTAG = tag;
  }

  /// 日志级别e
  static void e(Object object, {String tag}) {
    _printLog(tag, '  e  ', object);
  }

  /// 日志级别v
  static void v(Object object, {String tag}) {
    if (debuggable) {
      _printLog(tag, '  v  ', object);
    }
  }

  /// 输出日志
  static void _printLog(String tag, String stag, Object object) {
    String da = object.toString();
    String _tag = (tag == null || tag.isEmpty) ? _mTAG : tag;
    while (da.isNotEmpty) {
      if (da.length > 512) {
        print("$_tag $stag ${da.substring(0, 512)}");
        da = da.substring(512, da.length);
      } else {
        print("$_tag $stag $da");
        da = "";
      }
    }
  }
}
