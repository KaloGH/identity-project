import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:identity_project/screens/login_screen.dart';
import 'package:identity_project/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // Esperamos a que cargue archivo .env
  const _requiredEnvVars = [
    // Las variables de Firebase necesarias para cargar la página
    'FIREBASE_API_KEY',
    'FIREBASE_APP_ID',
    'FIREBASE_MESSAGING_SENDER_ID',
    'FIREBASE_PROJECT_ID',
    'FIREBASE_STORAGE_BUCKET'
  ];
  bool hasEnv = dotenv.isEveryDefined(
      _requiredEnvVars); // Comprobación de que están todas las variables
  // Si están todas las variables, cargamos la página
  if (hasEnv) {
    var firebaseApiKey = dotenv.env['FIREBASE_API_KEY'] ?? "";
    var firebaseAppID = dotenv.env['FIREBASE_APP_ID'] ?? "";
    var firebaseMessagingSenderID =
        dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? "";
    var firebaseProjectID = dotenv.env['FIREBASE_PROJECT_ID'] ?? "";
    var firebaseStorageBucket = dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? "";

    if (kIsWeb) {
      await Firebase.initializeApp(
        // Your web app's Firebase configuration
        options: FirebaseOptions(
          apiKey: firebaseApiKey,
          appId: firebaseAppID,
          messagingSenderId: firebaseMessagingSenderID,
          projectId: firebaseProjectID,
          storageBucket: firebaseStorageBucket,
        ),
      );
    } else {
      await Firebase.initializeApp();
    }
  } else {
    if (kDebugMode) {
      print("No se encontró el archivo .env");
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // Removes the debug banner from top side.
      title: 'iDentity',
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // home: const ResponsiveLayout(
      //   mobileScreenLayout: MobileScreenLayout(),
      //   webScreenLayout: WebScreenLayout(),
      // ),
      home: const LoginScreen(),
    );
  }
}
