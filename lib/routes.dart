import 'package:flutter/material.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/metier/choose_metier_screen.dart';
import 'screens/auth/register_admin_screen.dart';
import 'screens/entreprise/config_entreprise_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/auth/login_screen.dart';

class Routes {
  static const String splash = '/';
  static const String chooseMetier = '/choose-metier';
  static const String registerAdmin = '/register-admin';
  static const String configEntreprise = '/config-entreprise';
  static const String dashboard = '/dashboard';
  static const String login = '/login';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => SplashScreen(),
      chooseMetier: (context) => ChooseMetierScreen(),
      registerAdmin: (context) => RegisterAdminScreen(),
      configEntreprise: (context) => ConfigEntrepriseScreen(),
      dashboard: (context) => DashboardScreen(),
      login: (context) => LoginScreen(),
    };
  }
}
