import 'package:base_project/data/network/base_network_service.dart';
import 'package:base_project/data/network/network_api_service.dart';
import 'package:base_project/resources/api_constants.dart';

class SystemParamsRepo {
  final BaseNetworkService _networkService = NetworkApiService();

  Future<dynamic> getProfileImgApi(dynamic headers) async {
    try {
      final response = _networkService
          .getGetApiResponse(ApiConstants.getUserProfileImgEndpoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getProfileApi(dynamic headers) async {
    try {
      final response = _networkService
          .getGetApiResponse(ApiConstants.getUserProfileEndpoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateProfileApi(
      dynamic data, dynamic headers, dynamic uId) async {
    final uri = Uri.parse("${ApiConstants.updateUserProfileEndpoint}/$uId");

    try {
      final response =
          await _networkService.getPutApiResponse(uri.toString(), data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateProfileImg(dynamic data, dynamic headers) async {
    try {
      final response = await _networkService.getPostApiResponse(
          ApiConstants.updateUserProfileImgEndpoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getSystemParameters(dynamic headers, dynamic id) async {
    final uri = Uri.parse("${ApiConstants.updateSystemParams}/$id");
    try {
      final response = _networkService.getGetApiResponse(uri.toString());
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateSystemParameters(
      dynamic headers, dynamic body, dynamic enitiyId) async {
    try {
      final uri = Uri.parse("${ApiConstants.updateSystemParams}/$enitiyId");
      final response = _networkService.getPutApiResponse(uri.toString(), body);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
