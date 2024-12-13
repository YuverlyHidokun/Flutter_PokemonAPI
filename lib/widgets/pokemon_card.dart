import 'package:flutter/material.dart';
import '../models/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              pokemon.name.toUpperCase(),
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple[900],
              ),
            ),
            SizedBox(height: 16),
            Image.network(
              pokemon.imageUrl,
              height: 150,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 16),
            Text(
              "ID: ${pokemon.id}",
              style: TextStyle(fontSize: 18, color: Colors.deepPurple[700]),
            ),
            Text(
              "Altura: ${pokemon.height} dm",
              style: TextStyle(fontSize: 18, color: Colors.deepPurple[700]),
            ),
            Text(
              "Peso: ${pokemon.weight} hg",
              style: TextStyle(fontSize: 18, color: Colors.deepPurple[700]),
            ),
          ],
        ),
      ),
    );
  }
}
