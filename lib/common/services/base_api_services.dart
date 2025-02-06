abstract class BaseApiServices {
  Future<dynamic> getApi(String url);
  Future<dynamic> postApi(String url, dynamic body);
  Future<dynamic> patchApi(String url, dynamic body);
  Future<dynamic> deleteApi(String url);
}
