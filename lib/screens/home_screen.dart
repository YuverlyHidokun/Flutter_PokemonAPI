import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/pokemon.dart';
import '../widgets/pokemon_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final ApiService apiService = ApiService();
  Pokemon? _pokemon;
  String? _error;

  void _searchPokemon() async {
    final query = _controller.text.trim().toLowerCase();
    if (query.isNotEmpty) {
      try {
        final result = await apiService.fetchPokemon(query);
        setState(() {
          _pokemon = result;
          _error = null;
        });
      } catch (e) {
        setState(() {
          _pokemon = null;
          _error = "No se encontró el Pokémon.";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[800],
        title: Text(
          "Pokédex Morada",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.deepPurple[300],
                  labelText: "Buscar Pokémon",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search, color: Colors.white),
                    onPressed: _searchPokemon,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: _pokemon != null
                    ? PokemonCard(pokemon: _pokemon!)
                    : _error != null
                        ? Center(
                            child: Text(
                              _error!,
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 18,
                              ),
                            ),
                          )
                        : Center(
                            child: Text(
                              "Busca un Pokémon para empezar.",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
