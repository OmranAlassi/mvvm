//تحكم في الريكوست
import 'package:dio/dio.dart';

import '../../injection_container.dart';
import '../const/end_point.dart';
import '../utils/cache/cache_helper.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[ApiKey.contentType] = 'application/json';
    options.headers[ApiKey.accept] = 'application/json';
    options.headers[ApiKey.acceptLanguage] = 'ar';
    final token = sl<CacheHelper>().getData(key: ApiKey.token);
    options.headers[ApiKey.authorization] =
        token != null ? 'Bearer $token' : null;
    super.onRequest(options, handler);
  }
}
