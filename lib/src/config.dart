///配置
class GoodJobConfig {
  static GoodJobConfig config;

  static getInstances() {
    if (config == null) {
      config = GoodJobConfig();
    }
    return config;
  }

  ///初始化
  initAuth({apiKey = "", apiSecret = "", token = ""}) {
    mApiKey = apiKey;
    mApiSecret = apiSecret;
    tokenKey = token;
  }

  /// token
  static String tokenKey = "";

  /// api key
  static String mApiKey = '';

  /// secret key
  static String mApiSecret = '';
}
