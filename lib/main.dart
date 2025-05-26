import 'package:flutter/material.dart';
import 'core/constants/route_names.dart';
import 'views/auth/start_page.dart';
import 'views/auth/sign_in_page.dart';
import 'views/auth/sign_up_page.dart';
import 'views/auth/choose_option_page.dart';
import 'views/auth/verified_account_developer.dart';
import 'views/auth/verified_account_client.dart';
import 'views/developer/developer_info_page.dart';
import 'views/client/client_info_page.dart';
import 'views/bank/bank_account_page.dart';
import 'views/jobs/profile_setting_page.dart';
import 'views/home/home_page.dart';
import 'features/jobs/presentation/screens/website_page.dart';
import 'features/jobs/presentation/screens/category_details.dart';
import 'models/user_profile.dart';
import 'features/jobs/presentation/screens/about_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevLance Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      initialRoute: RouteNames.start,
      routes: {
        RouteNames.start: (context) => const StartPage(),
        RouteNames.signIn: (context) => const SignInPage(),
        RouteNames.signUp: (context) => const SignUpPage(),
        RouteNames.chooseOption: (context) => const ChooseOptionPage(),
        RouteNames.developerInfo: (context) => DeveloperInfoPage(
          username: ModalRoute.of(context)?.settings.arguments as String?,
        ),
        RouteNames.clientInfo: (context) => ClientInfoPage(
          username: ModalRoute.of(context)?.settings.arguments as String?,
        ),
        RouteNames.bankAccount: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          return BankAccountPage(
            profileArgs: args is UserProfile ? args : null,
          );
        },
        RouteNames.profileSetting: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args is UserProfile) {
            return ProfileSettingPage(
              profileArgs: args,
            );
          } else if (args is String) {
            return ProfileSettingPage(
              profileArgs: UserProfile(fullName: args, role: 'developer'),
            );
          }
          return const ProfileSettingPage();
        },
        RouteNames.home: (context) => const HomePage(),
        RouteNames.websites: (context) => const WebsitesPage(),
        RouteNames.categoryDetails: (context) => CategoryDetailsPage(
          category: ModalRoute.of(context)!.settings.arguments as String,
        ),
        RouteNames.about: (context) => const AboutPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == RouteNames.verifiedAccount) {
          final args = settings.arguments as Map<String, dynamic>? ?? {};
          final username = args['username'] as String? ?? '';
          final role = args['role'] as String? ?? 'developer';
          
          return MaterialPageRoute(
            builder: (context) => role == 'client'
                ? VerifiedAccountClient(username: username)
                : VerifiedAccountDeveloper(username: username),
          );
        }
        return null;
      },
    );
  }
}
