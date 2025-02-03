abstract class BaseApiServices {
  Future<dynamic> getApi(String url);
  Future<dynamic> postApi(String url, dynamic body);
  Future<dynamic> putApi(String url, dynamic body);
  Future<dynamic> deleteApi(String url);
}
