import 'package:demo_project/screens/home_screen.dart';
import 'package:demo_project/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'Controller/AllproductData_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo App',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),

      initialBinding: BindingsBuilder((){
        Get.lazyPut(() => AllProductDataController());
      }
      ),
      home: Scaffold(
        body: GetBuilder<AllProductDataController>(
          init: AllProductDataController(),
          builder: (controller) => HomeScreen(controller: controller),
        ),
      ),
    );
  }}


