import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pokedex/models/pokeapi.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/consts/consts_api.dart';
part 'pokeapi_store.g.dart';

// Mobx class for pokeapi
// after create, run command flutter packages pub run build_runner build to generate .g.dart file
// using watch instead build to keep watching changes

class PokeApiStore = _PokeApiStoreBase with _$PokeApiStore;

abstract class _PokeApiStoreBase with Store {
  @observable
  PokeAPI pokeAPI;

  @observable
  Pokemon _currentPokemon;

  @observable
  Color pokemonColor;

  @action
  fetchPokemonList() {
    pokeAPI = null;
    loadPokeAPI().then((pokeList) {
      pokeAPI = pokeList;
    });
  }

  Pokemon getPokemon({int index}) {
    return pokeAPI.pokemon[index];
  }

  @action
  setCurrentPokemon({int index}) {
    _currentPokemon = pokeAPI.pokemon[index];
    pokemonColor = ConstsApi.getColorType(type: _currentPokemon.type[0]);
  }

  @computed
  Pokemon get currentPokemon => _currentPokemon;

  @action
  Widget getImage({String number}) {
    return CachedNetworkImage(
      placeholder: (context, uri) => new Container(
        color: Colors.transparent,
      ),
      imageUrl:
          'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$number.png',
    );
  }

  Future<PokeAPI> loadPokeAPI() async {
    try {
      final response = await http.get(ConstsApi.pokeApiUrl);
      var decodeJson = jsonDecode(response.body);
      return PokeAPI.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print("Erro ao carregar lista" + stacktrace.toString());
      return null;
    }
  }
}
