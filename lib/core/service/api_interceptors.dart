//تحكم في الريكوست
import 'package:dio/dio.dart';
import 'package:mvvm/core/const/end_point.dart';
import 'package:mvvm/core/utils/cache/cache_helper.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[ApiKey.contentType] = 'application/json';
    options.headers[ApiKey.accept] = 'application/json';
    options.headers[ApiKey.acceptLanguage] = 'ar';
    options.headers[ApiKey.authorization] =
        CacheHelper().getData(key: ApiKey.token) != null
        ? 'Bearer ${CacheHelper().getData(key: ApiKey.token)}'
        : null;
    super.onRequest(options, handler);
  }
}
