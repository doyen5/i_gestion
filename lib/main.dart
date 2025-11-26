// ignore_for_file: use_key_in_widget_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_colors.dart';
import 'routes.dart';
import 'services/auth_service.dart';
import 'models/user_model.dart';
import 'firebase_options.dart'; // Ajoutez cette ligne

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisez Firebase avec les options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(IGestionApp());
}

class IGestionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<UserModel?>(
          create: (context) => AuthService().currentUser,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: 'I-GESTION',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primaryOrange,
          scaffoldBackgroundColor: AppColors.backgroundColor,
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.primaryOrange,
            foregroundColor: Colors.white,
          ),
          fontFamily: 'Arial', // Évite les problèmes de police
        ),
        initialRoute: Routes.splash,
        routes: Routes.getRoutes(),
      ),
    );
  }
}
