import 'package:example/App/Constant/App/HttpUrl.dart';
import 'package:example/App/Init/Screen/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'App/Controller/controller.dart';
import 'App/Init/Theme/GetTheme.dart';
import 'App/Init/Theme/AppDarkTheme.dart';
import 'App/Init/Theme/AppLightTheme.dart';
void main() {
  HttpUrl.baseUrl = 'https://sandbox2.siparisimapi.com/';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        SizeConfig().setScreenSizeFromConstraints(constraints);
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: getTheme(AppLightTheme()),
          darkTheme: getTheme(AppDarkTheme()),
          home: const MyHomePage(title: 'TS Product Detail'),
        );
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = Get.put(Controller());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      controller.getToken(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => controller.onTapGetProductBtn(context),
              child: const Text('Get Product Detail'),
            ),
            ElevatedButton(
              onPressed: () => controller.onTapGetPromotionProductBtn(context),
              child: const Text('Get Promotion Product Detail'),
            ),
          ],
        ),
      ),
    );
  }
}
