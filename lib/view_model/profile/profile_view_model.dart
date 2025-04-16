import 'dart:convert';
import 'dart:developer';

import 'package:base_project/data/response/api_response.dart';
import 'package:base_project/model/user/user_profile.dart';
import 'package:base_project/repository/profile/profile_repo.dart';
import 'package:base_project/utils/managers/user_manager.dart';
import 'package:base_project/utils/toast_messages/toast_message_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ProfileViewModel extends ChangeNotifier {
  final _repo = ProfileRepo();

  ApiResponse<UserProfile> userProfile = ApiResponse.loading();
  
  Uint8List? _profileImageBytes; // Variable for storing fetched image bytes

  bool _isUpdating = false;
  bool get isUpdating => _isUpdating;

  XFile? _profileImage;
  XFile? get profileImg => _profileImage;

  // Setters
  setUserProfile(ApiResponse<UserProfile> val) {
    userProfile = val;
    notifyListeners();
  }

  setUpdating(bool val) {
    _isUpdating = val;
    notifyListeners();
  }

  setImage(XFile? val) {
    _profileImage = val;
    notifyListeners();
  }

  setProfileImageBytes(Uint8List? val) {
    _profileImageBytes = val;
    notifyListeners();
  }

  // Picking an image from the gallery
  void pickImg(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setImage(image);
      updateImage(context);
    } else {
      ToastMessageUtil.showToast(
          message: "No image picked !!", toastType: ToastType.warning);
    }
  }

  // Fetching the user profile details
  Future<void> getProfile() async {
    setUserProfile(ApiResponse.loading());
    final headers = _getHeaders();

    _repo.getProfileApi(headers).then((value) {
      log("Profile Data--$value");
      setUserProfile(ApiResponse.success(UserProfile.fromJson(value)));
    }).onError((error, stackTrace) {
      log("ERROR--$error");
      setUserProfile(ApiResponse.error(error.toString()));
      ToastMessageUtil.showToast(
          message: "Error fetching profile data", toastType: ToastType.error);
    });
  }

  // Fetching the profile image
  Future<void> getProfileImg() async {
    final headers = _getHeaders();

    _repo.getProfileImgApi(headers).then((value) {
      String base64Image = value['image'];
      // Remove data URL prefix and decode base64
      Uint8List imageBytes = base64Decode(base64Image.split(',').last);
      setProfileImageBytes(imageBytes); // Store image bytes
    }).onError((error, stackTrace) {
      log("Error Fetching Image--$error");
      ToastMessageUtil.showToast(
          message: "Error fetching profile image", toastType: ToastType.error);
    });
  }

  // Updating the profile details
  Future<void> updateProfile(BuildContext context, dynamic data) async {
    setUpdating(true);
    final headers = _getHeaders();
    final uId = UserManager().userId;
    data['userId'] = uId.toString();
    print("Data--$data");
    _repo.updateProfileApi(data, headers,uId).then((value) {
      log("Profile Update--$value");
      setUpdating(false);
      getProfile();
      ToastMessageUtil.showToast(
          message: "Profile Updated", toastType: ToastType.success);
      Navigator.pop(context); // Close dialog/screen after update
    }).onError((error, stackTrace) {
      log("Error Updating Profile--$error");
      setUpdating(false);
      ToastMessageUtil.showToast(
          message: "Error updating profile!!", toastType: ToastType.error);
    });
  }

  // Updating the profile image
  Future<void> updateImage(BuildContext context) async {
    if (_profileImage == null) return; // Ensure an image is selected

    setUpdating(true);
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
      setUpdating(false);
      getProfileImg(); // Refresh the displayed image
      ToastMessageUtil.showToast(
          message: "Profile Image Updated", toastType: ToastType.success);
    }).onError((error, stackTrace) {
      log("Error Updating Image--$error");
      setUpdating(false);
      ToastMessageUtil.showToast(
          message: "Error updating image!!", toastType: ToastType.error);
    });
  }

  // Changing the password
  Future<void> changePassword(dynamic data) async {
    setUpdating(true);
    final headers = _getHeaders();
    log("BODY--$data");

    _repo.changPassApi(data, headers).then((value) {
      log("Password Change--$value");
      setUpdating(false);
      ToastMessageUtil.showToast(
          message: "Password updated", toastType: ToastType.success);
    }).onError((error, stackTrace) {
      log("Error Changing Password--$error");
      setUpdating(false);
      ToastMessageUtil.showToast(
          message: "Error updating password!!", toastType: ToastType.error);
    });
  }

  // Helper method to generate headers
  Map<String, String> _getHeaders() {
    log("-- GENERATING HEADERS -- ");
    final token = UserManager().token;
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  // Method to return image bytes (can be used in the UI to display)
  Uint8List? get profileImageBytes => _profileImageBytes;

  void reset() {
    _profileImage = null;
    _profileImageBytes = null;
    userProfile = ApiResponse.loading(); // Or any default state
    notifyListeners();
  }
}
