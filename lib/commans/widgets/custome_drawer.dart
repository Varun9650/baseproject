import 'package:base_project/utils/image_constant.dart';
import 'package:base_project/commans/widgets/custome_drawe_item.dart';
import 'package:base_project/resources/app_colors.dart';
import 'package:base_project/routes/route_names.dart';
import 'package:base_project/utils/managers/user_manager.dart';
import 'package:base_project/view_model/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class MyCustomDrawer extends StatelessWidget {
  const MyCustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final email = UserManager().email;
    final userName = UserManager().userName;
    final provider = Provider.of<ProfileViewModel>(context, listen: false);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.primary,
            ),
            currentAccountPicture: CircleAvatar(
              radius: 60,
              backgroundColor: AppColors.primary.withOpacity(0.3),
              backgroundImage: provider.profileImageBytes != null
                  ? MemoryImage(provider.profileImageBytes!)
                  : null,
              child: provider.profileImageBytes != null
                  ? null // Use backgroundImage for the actual image, so child should be null
                  : SvgPicture.asset(
                      ImageConstant.userProfileImg, // Placeholder SVG asset

// AppImages.userProfileImg, // Placeholder SVG asset
                      width: 60, // Adjust to fit the CircleAvatar
                      height: 60,
                    ),
            ),
            accountName: Text("Hello, $userName"),
            accountEmail: Text(email.toString()),
          ),
          DrawerItem(
            color: AppColors.primary,
            icon: Icons.person,
            title: 'Profile',
            onTap: () {
              Navigator.pushNamed(context, RouteNames.profileView);
            },
          ),
          DrawerItem(
            color: AppColors.primary,
            icon: Icons.system_security_update,
            title: 'System Parameters',
            onTap: () {
// Add navigation or other logic here
              Navigator.pushNamed(context, RouteNames.systemParamsView);
            },
          ),
          DrawerItem(
            color: AppColors.primary,
            icon: Icons.password,
            title: 'change password',
            onTap: () {
              Navigator.pushNamed(context, RouteNames.changePasswordView);
            },
          ),

// NEW MENU

          DrawerItem(
            icon: Icons.logout,
            color: Colors.red,
            title: 'Logout',
            onTap: () async {
              await UserManager().clearUser();
              Navigator.pushReplacementNamed(context, RouteNames.splashView);
            },
          ),
        ],
      ),
    );
  }
}
