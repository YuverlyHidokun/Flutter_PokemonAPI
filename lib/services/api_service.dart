import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class ApiService {
  final String baseUrl = "https://pokeapi.co/api/v2/pokemon";

  Future<Pokemon> fetchPokemon(String name) async {
    final response = await http.get(Uri.parse('$baseUrl/$name'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Pokemon.fromJson(data);
    } else {
      throw Exception("Failed to load Pokémon");
    }
  }
}
