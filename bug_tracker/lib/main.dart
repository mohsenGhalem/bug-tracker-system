import 'home/pages/home_page.dart';
import 'services/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth/view/auth_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true
      ),
      home: FutureBuilder<String>(
        future: SharedPrefs.token,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null && snapshot.data != '') {
              print("Token = ${snapshot.data}");
              return const HomePage();
            }
          }
          return  AuthView();
        },
      ),
      getPages: [
        GetPage(name: '/home', page:()=>const HomePage()),
        GetPage(name: '/auth', page:()=> AuthView()),
      ],
    );
  }
}
