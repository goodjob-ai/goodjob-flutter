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

  static String tokenKey = "";
  static String mApiKey = '';
  static String mApiSecret = '';
}
