import 'package:base_project/utils/toast_messages/toast_message_util.dart';
import 'package:base_project/view/auth/admin_reg_view.dart';
import 'package:base_project/view_model/auth/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:base_project/commans/widgets/custome_elevated_button.dart';
import 'package:provider/provider.dart';

class VerifyOtpView extends StatefulWidget {
  final String? email;

  const VerifyOtpView({super.key, this.email});

  @override
  _VerifyOtpViewState createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<VerifyOtpView> {
  // Create a TextEditingController for the Pinput field
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    // Dispose the controller when the widget is removed from the widget tree
    _otpController.dispose();
    super.dispose();
  }

  void _handleVerifyButtonPress() {
    // Get the OTP value from the controller
    final otp = _otpController.text;

    // Validate OTP value
    if (otp.isEmpty || otp.length < 6) {
      // Handle invalid OTP
      print("Invalid OTP: OTP must be 6 digits.");
      ToastMessageUtil.showToast(
          message: "Invalid OTP: OTP must be 6 digits.",
          toastType: ToastType.error);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.adaptive.arrow_back),
        ),
        title: const Text("Verify Otp"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                  "An OTP has been sent to your email. Please enter the OTP."),
              const SizedBox(height: 20),
              Pinput(
                length: 6, // Number of PIN digits
                controller: _otpController,
                pinAnimationType: PinAnimationType.fade,
                defaultPinTheme: PinTheme(
                  width: 50,
                  height: 50,
                  textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onCompleted: (pin) {
                  // Optionally handle OTP when completed
                  _handleVerifyButtonPress();
                },
              ),
              const SizedBox(height: 20),
              Consumer<AuthViewModel>(
                builder: (context, provider, child) {
                  return MyCustomElevatedButton(
                    isLoading: provider.isLoading,
                    onPressed: () {
                      if (_otpController.text.isEmpty ||
                          _otpController.text.length < 6) {
                        // Handle invalid OTP
                        print("Invalid OTP: OTP must be 6 digits.");
                        ToastMessageUtil.showToast(
                            message: "Invalid OTP: OTP must be 6 digits.",
                            toastType: ToastType.error);
                      } else {
                        final data = {
                          "email": widget.email,
                          "otp": _otpController.text
                        };
                        provider.verifyOtp(context, data);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminRegView(),
                            ));
                      }
                    },
                    child: const Text("Verify OTP"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
