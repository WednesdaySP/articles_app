import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/article_list_screen.dart';
import 'providers/article_provider.dart';

void main() {
  runApp(const MyApp() );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ArticleProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Article App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark, 
        home:  ArticleListScreen(),
      ),
    );
  }
}