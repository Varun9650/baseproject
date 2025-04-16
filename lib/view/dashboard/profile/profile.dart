import 'package:base_project/data/response/status.dart';
import 'package:base_project/resources/app_colors.dart';
import 'package:base_project/routes/route_names.dart';
import 'package:base_project/utils/image_constant.dart';
import 'package:base_project/utils/managers/user_manager.dart';
import 'package:base_project/view/dashboard/profile/edit_profile.dart';
import 'package:base_project/view_model/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final ProfileViewModel provider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider = Provider.of<ProfileViewModel>(context, listen: false);
      provider.getProfile();
      provider.getProfileImg();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.adaptive.arrow_back),
        ),
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Consumer<ProfileViewModel>(
              builder: (context, value, child) {
                switch (provider.userProfile.status) {
                  case null:
                  // TODO: Handle this case.
                  case Status.LOADING:
                    return SizedBox(
                      height: size.height * 0.2,
                      child: const Center(
                        child: CircularProgressIndicator.adaptive(
                          valueColor: AlwaysStoppedAnimation(AppColors.primary),
                        ),
                      ),
                    );
                  case Status.SUCCESS:
                    return Column(
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
                                  ImageConstant
                                      .userProfileImg, // Placeholder SVG asset
                                  width: 60, // Adjust to fit the CircleAvatar
                                  height: 60,
                                ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Text(
                          provider.userProfile.data?.fullName.toString() ??
                              "N/A",
                          style: textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          provider.userProfile.data?.email.toString() ?? "N/A",
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          provider.userProfile.data?.mobNo.toString() ?? "N/A",
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    );
                  case Status.ERROR:
                    return SizedBox(
                      height: size.height * 0.2,
                    );
                }
              },
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  _buildListTile(
                    context,
                    icon: Icons.edit,
                    title: 'Edit Profile',
                    trailingIcon: Icons.adaptive.arrow_forward,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfile(
                              userProfile: provider.userProfile.data!,
                            ),
                          ));
                    },
                  ),
                  const Divider(),
                  _buildListTile(
                    context,
                    icon: Icons.lock,
                    title: 'Change Password',
                    trailingIcon: Icons.adaptive.arrow_forward,
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.changePasswordView);
                    },
                  ),
                  const Divider(),
                  _buildListTile(
                    context,
                    icon: Icons.logout,
                    leadingIconColor: AppColors.error,
                    title: 'Logout',
                    //trailingIcon: Icons.adaptive.arrow_forward,
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Confirm Logout"),
                            content:
                                const Text("Are you sure you want to log out?"),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Dismiss the dialog
                                },
                              ),
                              TextButton(
                                child: const Text("Log Out"),
                                onPressed: () async {
                                  await UserManager().clearUser();
                                  Navigator.of(context)
                                      .pop(); // Dismiss the dialog
                                  Navigator.pushReplacementNamed(
                                      context, RouteNames.loginView);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    Color? leadingIconColor,
    required String title,
    IconData? trailingIcon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      leading: Icon(
        icon,
        color: leadingIconColor ?? AppColors.primary,
      ),
      title: Text(
        title,
      ),
      trailing: Icon(
        trailingIcon,
        color: AppColors.primary,
      ),
      onTap: onTap,
    );
  }
}
