import 'package:flutter/material.dart';
import 'package:movie_project/models/movie_data.dart';
import 'package:movie_project/screens/movies_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MovieData(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: BookGrid(),
    );
  }
}
