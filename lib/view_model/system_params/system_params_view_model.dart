import 'dart:developer';
import 'dart:typed_data';
import 'package:base_project/repository/system_params_repo.dart';
import 'package:base_project/utils/managers/user_manager.dart';
import 'package:base_project/utils/toast_messages/toast_message_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SystemParamsViewModel extends ChangeNotifier {
  final _repo = SystemParamsRepo();

  Uint8List? _profileImageBytes;
  XFile? _profileImage;
  bool _loading = false;

  // List to store system parameters
  Map<String, dynamic> _systemParamsList = {};

  // Getter for system parameters list
  Map<String, dynamic> get systemParamsList => _systemParamsList;

  // Getter for profile image bytes
  Uint8List? get profileImageBytes => _profileImageBytes;

  // Getter for profile image
  XFile? get profileImg => _profileImage;

  // Getter for loading status
  bool get loading => _loading;

  // Setter for loading status with notification to listeners
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // Setter for profile image
  setImage(XFile? val) {
    _profileImage = val;
    notifyListeners();
  }

  // Setter for profile image bytes
  setProfileImageBytes(Uint8List? val) {
    _profileImageBytes = val;
    notifyListeners();
  }

  // Method to pick an image from the gallery
  void pickImg(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setImage(image);
      // Optionally convert image to bytes and store
      final bytes = await image.readAsBytes();
      setProfileImageBytes(bytes);
      updateImage(context);
    } else {
      ToastMessageUtil.showToast(
          message: "No image picked !!", toastType: ToastType.warning);
    }
  }

  // Method to fetch system parameters and store them in a list
  Future<void> getSystemParams(dynamic id) async {
    loading = true;
    final headers = _getHeaders();
    try {
      final value = await _repo.getSystemParameters(headers, id);
      print("----SYSTEM-PARAMS----");
      _systemParamsList = value; // Store the fetched parameters in the list
      loading = false;
      print(value);
    } catch (error) {
      loading = false;
      print("Error-$error");
    }
  }

  // Method to update system parameters
  Future<void> updateSystemParams(
      Map<String, dynamic> body, int entityId) async {
    loading = true;
    final headers = _getHeaders();
    try {
      final value = await _repo.updateSystemParameters(headers, body, entityId);
      print("----SYSTEM-PARAMS----");
      loading = false;
      print(value);
      ToastMessageUtil.showToast(
          message: "System parameters updated!!", toastType: ToastType.success);
    } catch (error) {
      loading = false;
      print("Error-$error");
      ToastMessageUtil.showToast(
          message: error.toString(), toastType: ToastType.error);
    }
  }

  // Updating the profile image
  Future<void> updateImage(BuildContext context) async {
    if (_profileImage == null) return; // Ensure an image is selected

    loading = true;
    final headers = _getHeaders();
    Uint8List fileBytes = await _profileImage!.readAsBytes();

    FormData formData = FormData.fromMap({
      'imageFile': MultipartFile.fromBytes(
        fileBytes,
        filename: _profileImage!.name,
      ),
    });

    _repo.updateProfileImg(formData, headers).then((value) {
      log("Image Update--$value");
      loading = false;
      ToastMessageUtil.showToast(
          message: "Profile Image Updated", toastType: ToastType.success);
    }).onError((error, stackTrace) {
      log("Error Updating Image--$error");
      loading = false;
      // setUpdating(false);
      ToastMessageUtil.showToast(
          message: "Error updating image!!", toastType: ToastType.error);
    });
  }

  // Helper method to generate headers
  Map<String, String> _getHeaders() {
    final token = UserManager().token;
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }
}
