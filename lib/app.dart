import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_photo/scenes/connection_bloc/connection_bloc.dart';
import 'package:unsplash_photo/scenes/home_page.dart';
import 'package:unsplash_photo/scenes/picture_page.dart';
import 'package:unsplash_photo/scenes/unsplash_bloc/unsplash_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unsplash Photo',
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(providers: [
        BlocProvider(
            create: (BuildContext context) =>
                UnsplashBloc()..add(UnsplashInitialPageEvent())),
        BlocProvider(
            create: (BuildContext context) =>
                ConnectivityBloc()..add(CheckConnectionEvent()))
      ], child: const SafeArea(child: HomePage())),
    onGenerateRoute: (RouteSettings settings) {
      switch (settings.name) {
        case "/pictureView":
          return MaterialPageRoute(builder: (context) {
            return PictureViewPage(
              url: (settings.arguments as Map<String, dynamic>)["url"],
              hash: (settings.arguments as Map<String, dynamic>)["hash"],
              userImageUrl: (settings.arguments
              as Map<String, dynamic>)["userImageUrl"],
              username:
              (settings.arguments as Map<String, dynamic>)["username"],
              dominantColor: (settings.arguments
              as Map<String, dynamic>)["dominantColor"]
            );
          });
      }
    },
      theme: ThemeData(primaryColor: Colors.black),
    );
  }
}
