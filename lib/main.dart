import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/Models/news_data_model.dart';
import 'package:news_app/Screens/home_screen.dart';
import 'package:news_app/Services/api_services.dart';
import 'package:news_app/blocs/Internet/internet_bloc_bloc.dart';
import 'package:news_app/blocs/News/news_bloc_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter();
  Hive.init(directory.path);
  Hive.registerAdapter<News>(NewsAdapter());
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => InternetBloc(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            themeMode: ThemeMode.light,
            darkTheme: ThemeData.dark(),
            theme: ThemeData(
              appBarTheme: const AppBarTheme(color: Colors.black87),
              primaryColor: Colors.grey,
              canvasColor: Colors.grey[700],
              fontFamily: 'Roboto Slab',
            ),
            home: child,
          ),
        );
      },
      child: BlocProvider<NewsBloc>(
        create: (context) => NewsBloc(NewsRepository()),
        child: const HomeScreen(),
      ),
    );
  }
}
