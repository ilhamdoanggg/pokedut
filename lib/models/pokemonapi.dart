import 'dart:convert';

import 'package:http/http.dart';
import 'package:kt_dart/collection.dart';
import 'package:pokedut/config/config.dart';
import 'package:pokedut/models/pokemon/pokemon.dart';

class PokemonApi {
  PokemonApi();
  final Client _client = Client();

  static const String baseUlr = pokemonBaseApi;
  Uri pokemonLisUrl() {
    return Uri.https(pokemonAuthority, '$pokemonAuthority/pokemon');
  }

  Future<KtList<Pokemon>> getPokemonList([int offset = 0]) async {
    const perPage = 20;
    final Response response = await _client
        .get('${pokemonLisUrl()}?offset=$offset&limit=$perPage' as Uri);
    final decoded = jsonDecode(response.body);
    print({decoded});
    final results = decoded['results'];

    return listFrom(results).map((item) => Pokemon.fromJson(item));
  }
}
