import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex/consts/consts_app.dart';
import 'package:pokedex/models/pokeapi.dart';
import 'package:pokedex/pages/home/widgets/app_bar_home.dart';
import 'package:pokedex/stores/pokeapi_store.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PokeApiStore pokeApiStore;

  @override
  void initState() {
    super.initState();
    pokeApiStore = PokeApiStore();
    pokeApiStore.fetchPokemonList();
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double statusWidth = MediaQuery.of(context).padding.top;
    double imgSize = 240;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            top: -(imgSize / 4.7),
            left: screenWidth - (imgSize / 1.6),
            child: Opacity(
            opacity: 0.1,
            child: Image.asset(
              ConstsApp.blackPokeball,
              height: imgSize,
              width: imgSize,
            )
          ),
        ),
        Container(
          child: Column(
            children: <Widget>[
              Container(
                height: statusWidth,
              ),
              AppBarHome(),
              Expanded(
                child: Container(
                  child: Observer(
                    builder: (BuildContext context) {
                      PokeAPI _pokeAPI = pokeApiStore.pokeAPI;
                      return _pokeAPI != null ? 
                      ListView.builder(
                        itemCount: _pokeAPI.pokemon.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_pokeAPI.pokemon[index].name) 
                          );
                        }
                      ) : Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  )
                ),
              )
            ],
          ),
        )
      ],
      ),
    );
  }
}