import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onflare/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        GetMaterialApp(
          home: const Scaffold(
            backgroundColor: Colors.white,
            body: HomeScreen(),
          ),
          builder: (context, child) {
            return ScrollConfiguration(behavior: AppBehavior(), child: child!);
          },
          theme: ThemeData(
            fontFamily: 'Pretendard',
            useMaterial3: false,
          ),
          debugShowCheckedModeBanner: false,
        ),
      );
    },
  );
}

class AppBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
