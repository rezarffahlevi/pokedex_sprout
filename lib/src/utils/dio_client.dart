import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';

class DioClient {
  String? baseUrl;

  DioClient({this.baseUrl});

  Dio get dio => _getDio();

  static String getBaseUrl() {
    return 'https://pokeapi.co';
  }

  static Duration? _getTimeOutDuration() {
    return const Duration(seconds: 30);
  }

  Dio _getDio() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl ?? getBaseUrl(),
      connectTimeout: _getTimeOutDuration(),
      receiveTimeout: _getTimeOutDuration(),
    );

    Dio dio = Dio(options);
    dio.interceptors.addAll([
      _interceptor(),
    ]);
    return dio;
  }

  setHeader(RequestOptions options) async {
    String jwtToken = 'D3faultToken';

    options.headers["Authorization"] = 'Basic $jwtToken';
    options.headers["Access-Control-Allow-Origin"] = '*';
    options.headers["Accept"] = '*/*';
    options.headers["Content-Type"] = "application/json";
  }

  Interceptor _interceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        await setHeader(options);
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        // log('ResponseLog ${response.requestOptions.method} ${response.realUri} \n'
        //     '-- headers --\n'
        //     '${tryEncode(response.requestOptions.headers)} \n'
        //     '-- queryParameters --\n'
        //     '${tryEncode(response.requestOptions.queryParameters)} \n'
        //     '-- data --\n'
        //     '${tryEncode(response.requestOptions.data ?? '').replaceAll('\\"', '"')} \n'
        //     '-- response --\n'
        //     '${tryEncode(response.data)} \n'
        //     '');
        return handler.next(response);
      },
      onError: (DioException err, handler) async {
        final options = err.requestOptions;

        log('\n'
            'ResponseLog Error ${options.method} ${options.uri} --> $err \n'
            '-- headers --\n'
            '${tryEncode(options.headers)} \n'
            '-- queryParameters --\n'
            '${tryEncode(options.queryParameters)} \n'
            '-- data --\n'
            '${options.data ?? ''} \n'
            '-- response --\n'
            '${tryEncode(err.response?.data ?? '')} \n'
            '');
        return handler.reject(err);
      },
    );
  }

  String tryEncode(data) {
    try {
      String jsonString = json.encode(data);
      return jsonString;
    } catch (e) {
      return '-';
    }
  }
}
