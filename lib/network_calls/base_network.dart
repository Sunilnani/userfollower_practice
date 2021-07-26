import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class DioClient {
  factory DioClient() {
    return _singleton;
  }

  DioClient._internal() {
    init();
  }

  static final DioClient _singleton = DioClient._internal();

  late Dio _dio;
  late Dio _tokenDio;

  static SharedPreferences? prefs;

  int authFailCount = 0;

  String token = "";
  String deviceInfo = "";

  Future<String> _getAuthorizationToken() async {
    prefs ??= await SharedPreferences.getInstance();
    token = prefs?.getString("token") ?? "";
    print(token);
    return token;
  }

  Future<String> _getDeviceInfo() async {
    prefs ??= await SharedPreferences.getInstance();
    deviceInfo = prefs?.getString("token") ?? "";
    print(deviceInfo);
    return deviceInfo;
  }

  String getDeviceInfo() {
    return deviceInfo;
  }
  String getAuthorizationToken() {
    return token;
  }

  dynamic init() {
    _dio = Dio();
    _dio.options = BaseOptions(
        validateStatus: (status) => status! < 500,
        baseUrl: "https://api.github.com");
    // Used to get token
    _tokenDio = Dio();
    _tokenDio.options = BaseOptions(
      validateStatus: (status) => status! < 500,
      baseUrl: "https://api.github.com",
    );
    _tokenDio.interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) async {
        return handler.next(options);
      }, onResponse: (response, handler) async {
        debugPrint(response.realUri.toString());

        debugPrint(response.statusCode.toString());
        return handler.next(response);
      }, onError: (error, handler) {
        debugPrint(error.response?.realUri.toString());
        debugPrint(error.response?.statusCode.toString());
        return handler.next(error);
      }),
    );

    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      options.headers['Accept'] = 'application/json';
      if (options.headers.keys.contains('Content-Type'.toLowerCase())) {
        options.headers.remove('Content-Type'.toLowerCase());
      }
      options.headers['Content-Type'] = 'application/json';

      options.queryParameters['platform'] = 'mobile';

      final token = await _getAuthorizationToken();
      if (token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      final deviceInfo = await _getDeviceInfo();
      if (deviceInfo.isNotEmpty) {
        options.headers['device_info'] = deviceInfo;
      }

      return handler.next(options);
    }, onResponse: (response, handler) async {
      // Do something with response data
      // TODO: Remove Print Statements
      debugPrint(response.realUri.toString());
      debugPrint(response.statusCode.toString());

      if (response.statusCode == 401) {
        // _dio.interceptors.requestLock.lock();
        // _dio.interceptors.responseLock.lock();
        final options = response.requestOptions;

        return handler.next(response);

        authFailCount += 1;


      } else {
        authFailCount = 0;
        return handler.resolve(response);
      }
    }, onError: (error, handler) async {
      // TODO: Remove Print Statements
      debugPrint('Error');
      debugPrint(error.response?.realUri.toString());
      debugPrint(error.response?.data.toString());
      debugPrint(error.response?.statusCode?.toString() ?? '');


      if (error.response?.statusCode == 401) {
        _dio.interceptors.requestLock.lock();
        _dio.interceptors.responseLock.lock();
        final options = error.response?.requestOptions;

        return handler.reject(error);


      } else {
        return handler.reject(error);
      }
    })
    );
  }

  Dio get ref => _dio;

  Dio get tokenRef => _tokenDio;
}

final dioClient = DioClient();