import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:identity_project/responsive/mobile_screen_layout.dart';
import 'package:identity_project/responsive/responsive_layout_screen.dart';
import 'package:identity_project/responsive/web_screen_layout.dart';
import 'package:identity_project/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      // Your web app's Firebase configuration
      options: const FirebaseOptions(
        apiKey: "***REMOVED***",
        appId: "***REMOVED***",
        messagingSenderId: "***REMOVED***",
        projectId: "***REMOVED***",
        storageBucket: "***REMOVED***.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
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
      home: const ResponsiveLayout(
        mobileScreenLayout: MobileScreenLayout(),
        webScreenLayout: WebScreenLayout(),
      ),
    );
  }
}
