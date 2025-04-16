import 'package:base_project/resources/app_colors.dart';
import 'package:base_project/routes/route_names.dart';
import 'package:base_project/view_model/auth/auth_view_model.dart';
import 'package:base_project/view_model/profile/profile_view_model.dart';
import 'package:base_project/view_model/system_params/system_params_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'routes/app_routes.dart';
import 'utils/managers/user_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserManager().initialize();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AuthViewModel(),
      ),
      ChangeNotifierProvider(
        create: (context) => ProfileViewModel(),
      ),
      ChangeNotifierProvider(
        create: (context) => SystemParamsViewModel(),
      ),
      // ChangeNotifierProvider(
      //   create: (context) => BasicpViewModelScreen(),
      // ),
    ],
    child: const MyApp(),
  ));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Set the navigation bar color when the app starts
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor:
          AppColors.primary, // Set your desired color here
      systemNavigationBarIconBrightness: Brightness.light, // Icons color
    ));
    return MaterialApp(
      theme: ThemeData(
          primaryColor: AppColors.primary,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: false,
          scaffoldBackgroundColor: Colors.grey[200],
          drawerTheme: DrawerThemeData(backgroundColor: Colors.grey[200]),
          iconTheme: const IconThemeData(color: AppColors.primary),
          appBarTheme: const AppBarTheme(
              scrolledUnderElevation: 0, backgroundColor: AppColors.primary)),
      title: 'Base Project',
      debugShowCheckedModeBanner: false,
      //  home: const SysParameter(),
      initialRoute: RouteNames.splashView,
      onGenerateRoute: AppRoutes.generateRoutes,
    );
  }
}
