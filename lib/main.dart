import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:viva_store_app/Pages/product_catalog_page.dart';
import 'package:viva_store_app/config/color_palette.dart';
import 'package:viva_store_app/providers/productProvider.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
    create: (context) => ProductProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Viva Store App',
      theme: ThemeData(
        primaryColor: ColorPalette.primaryColor,
      ),
      home: ProductCatalogPage(),
    );
  }
}
