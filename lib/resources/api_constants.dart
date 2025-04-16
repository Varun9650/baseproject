class ApiConstants {
// USER AUTH API'S //
  static const loginEndpoint = "$baseUrl/token/session";
  static const getOtpEndpoint = "$baseUrl/token/user/send_email";
  static const resendOtpEndpoint = "$baseUrl/token/user/resend_otp";
  static const verifyEndpoint = "$baseUrl/token/user/otp_verification";
  static const createUserEndpoint = "$baseUrl/token/addOneAppUser";
  static const createAcEndpoint =
      "$baseUrl/token/users/sysaccount/savesysaccount";

// PROFILE API'S //
  static const getUserProfileEndpoint = '$baseUrl/api/user-profile';
  static const getUserProfileImgEndpoint = '$baseUrl/api/retrieve-image';
  static const updateUserProfileEndpoint = '$baseUrl/api/updateAppUserDto';
  static const updateUserProfileImgEndpoint = '$baseUrl/api/upload';
  static const changePasswordEndpoint = '$baseUrl/api/reset_password';
  static const forgotPasswordEndpoint = '$baseUrl/api/resources/forgotpassword';

// SYSTEM PARAMS API'S //
  static const uploadSystemParamImg = '$baseUrl/api/logos/upload?ref=test';
  static const getSystemParameters = '$baseUrl/sysparam/getSysParams';
  static const updateSystemParams = '$baseUrl/sysparam/updateSysParams';

  static const baseUrl = 'http://localhost:9292';
}
