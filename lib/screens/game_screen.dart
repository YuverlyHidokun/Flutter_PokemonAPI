import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String deckId = "";
  String? playerCardImage;
  String? aiCardImage;
  String? result;

  @override
  void initState() {
    super.initState();
    _initializeDeck();
  }

  // Inicializa un nuevo mazo barajado
  Future<void> _initializeDeck() async {
    final response = await http.get(Uri.parse("https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        deckId = data['deck_id'];
      });
    }
  }

  // Saca dos cartas y determina el ganador
  Future<void> _drawCards() async {
    if (deckId.isEmpty) return;

    final response = await http.get(Uri.parse("https://deckofcardsapi.com/api/deck/$deckId/draw/?count=2"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final playerCard = data['cards'][0];
      final aiCard = data['cards'][1];

      final playerValue = _getCardValue(playerCard['value']);
      final aiValue = _getCardValue(aiCard['value']);

      setState(() {
        playerCardImage = playerCard['image'];
        aiCardImage = aiCard['image'];

        if (playerValue > aiValue) {
          result = "¡Ganaste! 🎉";
        } else if (playerValue < aiValue) {
          result = "Perdiste. 😔";
        } else {
          result = "Es un empate. 🤝";
        }
      });
    }
  }

  // Convierte el valor de la carta a un número
  int _getCardValue(String value) {
    switch (value) {
      case "JACK":
        return 11;
      case "QUEEN":
        return 12;
      case "KING":
        return 13;
      case "ACE":
        return 14;
      default:
        return int.parse(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.deepPurple[800]!,
            Colors.deepPurple[400]!,
            Colors.deepPurple[200]!,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "¡Adivina la carta más alta!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (playerCardImage != null)
                Image.network(playerCardImage!, height: 150),
              if (aiCardImage != null)
                Image.network(aiCardImage!, height: 150),
            ],
          ),
          SizedBox(height: 20),
          if (result != null)
            Text(
              result!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          SizedBox(height: 20),
          ElevatedButton(
          onPressed: _drawCards,
          child: Text("Sacar cartas"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple[700], // Cambia 'primary' por 'backgroundColor'
            foregroundColor: Colors.white,          // Cambia 'onPrimary' por 'foregroundColor'
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
          ),

        ],
      ),
    );
  }
}
