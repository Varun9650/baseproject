import 'dart:async';
import 'package:base_project/repository/auth_repo.dart';
import 'package:base_project/routes/route_names.dart';
import 'package:base_project/utils/flushbar_messages/flush_message_util.dart';
import 'package:base_project/utils/managers/user_manager.dart';
import 'package:base_project/utils/toast_messages/toast_message_util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AuthViewModel extends ChangeNotifier{

  final AuthRepo _authRepo = AuthRepo();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

  Timer? _timer;
  int _start = 120;
  bool _isResendEnabled = false;

  int get start => _start;
  bool get isResendEnabled => _isResendEnabled;

  void startTimer() {
    _isResendEnabled = false;
    _start = 120; // Set the timer duration (in seconds)
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_start == 0) {
        _timer?.cancel();
        _isResendEnabled = true;
        notifyListeners();
      } else {
        _start--;
        print(_start);
        notifyListeners();
      }
    });
  }

  var accId = "";
  var uEmail = "";


  Future<void> login(BuildContext context, dynamic data) async {
    setLoading(true);

    try {
      final value = await _authRepo.loginApi(data);
      print("Value-$value");

      // Check the response structure
      if (value['operationStatus'] == 'SUCCESS') {
        final item = value['item'];
        await UserManager().setUser(item);
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn',true) ;
        // Handle successful login
        ToastMessageUtil.showToast(message: 'Logged in as ${value['item']['email']}', toastType: ToastType.general);
        // nav to home
         Navigator.pushReplacementNamed(context, RouteNames.homeView);

      } else {
        print("Error");
        // Handle login failure
        FlushBarMessageUtil.showFlushBar(
          context: context,
          message: "Failed!!  Email or Password is incorrect",
          flushBarType: FlushBarType.error,
        );
      }
    } catch (error, stackTrace) {
      print("Error -$error");
      print("st -$stackTrace");
      // Handle any other errors
      FlushBarMessageUtil.showFlushBar(
        context: context,
        message: error.toString(),
        flushBarType: FlushBarType.error,
      );
    } finally {
      setLoading(false);
    }
  }

  Future<void> signUp(BuildContext context, dynamic data) async {
    setLoading(true);
    final createUserData = {
        ...data,
        'account_id' :accId
      };
      print("CreateUserData--$createUserData");

      _authRepo.createUserApi(createUserData).then((value) {
        print(value);
        ToastMessageUtil.showToast(message: "Account Created",toastType: ToastType.success);
        setLoading(false);
        Navigator.pushReplacementNamed(context, RouteNames.loginView);
      }).onError((error, stackTrace) {
        print(error);
        print(stackTrace);
        FlushBarMessageUtil.showFlushBar(context: context, message:error.toString(),flushBarType: FlushBarType.error);
        setLoading(false);
      },);

  }

  Future<void> createAcc(BuildContext context,dynamic data)async{
    setLoading(true);
    _authRepo.createAcApi(data).then((value) {
      print("Value--$value");
       accId = value['account_id'].toString();
       setLoading(false);
      ToastMessageUtil.showToast(message: "Success creating account",toastType: ToastType.success);
     // Navigator.pushNamed(context, RouteNames.signUp,arguments: uEmail);
    },).onError((error, stackTrace) {
      print("error--$error");
      setLoading(false);
      ToastMessageUtil.showToast(message: "Error registering your account",toastType: ToastType.error);
    },);

  }
  Future<void> getOtp(BuildContext context, dynamic data) async {
    setLoading(true);

    try {
      await _authRepo.getOtpApi(data).then((value) {
        // Assuming the API call was successful
        print(value);
        ToastMessageUtil.showToast(
          message: "OTP sent successfully",
          toastType: ToastType.success,
        );
        Navigator.pushNamed(context, RouteNames.verifyOtpView, arguments: {'email': data['email']},);
      }).catchError((error) {
        // Check for specific error messages
        final errorMessage = error.toString();
        print("Error--$errorMessage");
        if (!errorMessage.contains("already exists")) {
          ToastMessageUtil.showToast(
            message: "Email already in use.",
            toastType: ToastType.error,
          );
        } else {
          ToastMessageUtil.showToast(
            message: "An unexpected error occurred",
            toastType: ToastType.error,
          );
        }
      });
    } catch (error) {
      // Handle any other exceptions
      print(error);
      ToastMessageUtil.showToast(
        message: 'An unexpected error occurred',
        toastType: ToastType.error,
      );
    } finally {
      setLoading(false);
    }
  }
  Future<void> resendOtp(BuildContext context, dynamic data) async {
    startTimer();
      await _authRepo.resendOtpApi(data).then((value) {
        print(value);
        ToastMessageUtil.showToast(
          message: "OTP resend successfully",
          toastType: ToastType.success,
        );

      }).onError((error, stackTrace) {
        print(error);
        ToastMessageUtil.showToast(
          message: "Failed to resend OTP",
          toastType: ToastType.error,
        );
      },);
  }

  Future<void> verifyOtp(BuildContext context, dynamic queryParams )async{
    print("Verifying otp");
    setLoading(true);
    _authRepo.verifyOtpApi(queryParams).then((value) {
      print(value);
      ToastMessageUtil.showToast(message: "Otp Verified!!",toastType: ToastType.success);
      setLoading(false);
       uEmail = queryParams['email'];
     // Navigator.pushNamed(context, RouteNames.registerAdmin);
      cancelTimer();
    },).onError((error, stackTrace) {
      print(error);
      ToastMessageUtil.showToast(
        message: "Otp Verification failed",
        toastType: ToastType.error,
      );
      setLoading(false);
    },);
  }

  void cancelTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    cancelTimer(); // Ensure the timer is cancelled
    super.dispose();
  }


}
