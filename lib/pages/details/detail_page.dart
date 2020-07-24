import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex/consts/consts_api.dart';
import 'package:pokedex/models/pokeapi.dart';
import 'package:pokedex/stores/pokeapi_store.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class DetailsPage extends StatelessWidget {

  final int index;
  final String name;
  Color _pokemonColor;

  DetailsPage({Key key, this.index, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pokeApiStore = Provider.of<PokeApiStore>(context);
    final pokemon = _pokeApiStore.currentPokemon;
    _pokemonColor = ConstsApi.getColorType(type: pokemon.type[0]);

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(48.0),
            child: Observer(
              builder: (context) {
                _pokemonColor = ConstsApi.getColorType(type: _pokeApiStore.currentPokemon.type[0]);
                
                return AppBar(
                  title: Opacity(
                    opacity: 0.0,
                    child: Text(
                      pokemon.name,
                      style: TextStyle(
                        fontFamily: 'Google',
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0
                      ),
                    ),
                  ),
                  elevation: 0,
                  backgroundColor: _pokemonColor,
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: () {},
                    )
                  ],
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () { Navigator.pop(context);},
                  )
                );
              }
            ),
          ),
          body: Stack(
            children: <Widget>[
              Observer(
                builder: (BuildContext context) { 
                  _pokemonColor = ConstsApi.getColorType(type: _pokeApiStore.currentPokemon.type[0]);
                  return Container(
                    color: _pokemonColor,
                  );
                },             
              ),

              Container(
                height: MediaQuery.of(context).size.height / 3,
              ),

              SlidingSheet(
                elevation: 0.0,
                cornerRadius: 16.0,
                snapSpec: const SnapSpec(
                  snap: true,
                  snappings: [0.7, 1.0],
                  positioning: SnapPositioning.relativeToAvailableSpace,
                ),
                builder: (context, state) {
                  return Container(
                    height: 500,
                    
                  );
                },
              ),

              Padding(
                padding: EdgeInsets.only(top: 48.0),
                child: SizedBox(
                  height: 150.0,
                  child: PageView.builder(
                    onPageChanged: (index) {
                      _pokeApiStore.setCurrentPokemon(index: index);
                    },

                    itemCount: _pokeApiStore.pokeAPI.pokemon.length,
                    itemBuilder: (BuildContext context, int index) {
                      Pokemon _pkm = _pokeApiStore.getPokemon(index: index);
                      return CachedNetworkImage(
                        height: 80.0,
                        width: 80.0,
                        placeholder: (context, uri) => new Container( color: Colors.transparent,),
                        imageUrl: 'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${_pkm.num}.png',
                      );
                    }
                  ),
                ),
              )
            ],
          ),
        );
  }
}