import 'package:base_project/data/network/no_token_base_network_service.dart';
import 'package:base_project/resources/api_constants.dart';

import '../data/network/no-token_network_api_service.dart';

class AuthRepo {
  final NoTokenBaseNetworkService _service = NoTokenNetworkApiService();

  Future<dynamic> loginApi(dynamic body) async {
    try {
      final res =
          await _service.getPostApiResponse(ApiConstants.loginEndpoint, body);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getOtpApi(dynamic body) async {
    try {
      final res =
          await _service.getPostApiResponse(ApiConstants.getOtpEndpoint, body);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> verifyOtpApi(dynamic body) async {
    try {
      final res =
          await _service.getPostApiResponse(ApiConstants.verifyEndpoint, body);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> resendOtpApi(dynamic body) async {
    try {
      final res = await _service.getPostApiResponse(
          ApiConstants.createAcEndpoint, body);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> createUserApi(dynamic body) async {
    try {
      final res = await _service.getPostApiResponse(
          ApiConstants.createUserEndpoint, body);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> createAcApi(dynamic body) async {
    try {
      final res = await _service.getPostApiResponse(
          ApiConstants.createAcEndpoint, body);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
