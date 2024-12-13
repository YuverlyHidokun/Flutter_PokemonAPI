import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/game_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokédex & Cards Game',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: MainTabView(),
    );
  }
}

class MainTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Pokédex & Card Game"),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.catching_pokemon), text: "Pokédex"),
              Tab(icon: Icon(Icons.sports_esports), text: "Card Game"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HomeScreen(),
            GameScreen(),
          ],
        ),
      ),
    );
  }
}
