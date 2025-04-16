import 'package:base_project/commans/widgets/custom_textform_field.dart';
import 'package:base_project/commans/widgets/custome_elevated_button.dart';
import 'package:base_project/model/user/user_profile.dart';
import 'package:base_project/resources/app_colors.dart';
import 'package:base_project/view_model/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../utils/image_constant.dart';

class EditProfile extends StatefulWidget {
  final UserProfile userProfile;
  const EditProfile({super.key, required this.userProfile});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController _emailController;
  late TextEditingController _userNameController;
  late TextEditingController _mobNoController;
  late TextEditingController _fullNameController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.userProfile.email);
    _userNameController =
        TextEditingController(text: widget.userProfile.username);
    _mobNoController =
        TextEditingController(text: widget.userProfile.mobNo.toString());
    _fullNameController =
        TextEditingController(text: widget.userProfile.fullName.toString());
  }

  @override
  void dispose() {
    _emailController.dispose();
    _userNameController.dispose();
    _mobNoController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.adaptive.arrow_back,
              color: AppColors.textWhite,
            )),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        title: const Text(
          'Edit Profile',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Profile Photo Section
              Consumer<ProfileViewModel>(
                builder: (context, provider, _) {
                  return Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: AppColors.primary.withOpacity(0.3),
                          backgroundImage: provider.profileImageBytes != null
                              ? MemoryImage(provider.profileImageBytes!)
                              : null,
                          child: provider.profileImageBytes != null
                              ? null // Use backgroundImage for the actual image, so child should be null
                              : SvgPicture.asset(
                                  ImageConstant.userProfileImg,
                                  // imgco.userProfileImg, // Placeholder SVG asset
                                  width: 60, // Adjust to fit the CircleAvatar
                                  height: 60,
                                ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 10,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt),
                              color: Colors.white,
                              onPressed: () {
                                provider.pickImg(context);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),

              MyCustomTextFormField(
                controller: _fullNameController,
                label: "Full Name",
              ),
              const SizedBox(height: 20),

              MyCustomTextFormField(
                controller: _emailController,
                label: "Email",
              ),
              const SizedBox(height: 20),

              MyCustomTextFormField(
                controller: _mobNoController,
                label: "Phone",
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
              ),
              const SizedBox(height: 40),

              Consumer<ProfileViewModel>(builder: (context, provider, _) {
                return Center(
                  child: MyCustomElevatedButton(
                    isLoading: provider.isUpdating,
                    onPressed: () {
                      final data = {
                        // 'username': _userNameController.text,
                        'email': _emailController.text,
                        'fullName': _fullNameController.text,
                        'mob_no': _mobNoController.text,
                      };
                      provider.updateProfile(context, data);
                    },
                    child: const Text("Save Changes"),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
