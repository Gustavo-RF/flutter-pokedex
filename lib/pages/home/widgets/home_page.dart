import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex/consts/consts_app.dart';
import 'package:pokedex/models/pokeapi.dart';
import 'package:pokedex/pages/details/detail_page.dart';
import 'package:pokedex/pages/home/widgets/app_bar_home.dart';
import 'package:pokedex/pages/home/widgets/poke_item.dart';
import 'package:pokedex/stores/pokeapi_store.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PokeApiStore _pokeApiStore;

  @override
  Widget build(BuildContext context) {
    _pokeApiStore = Provider.of<PokeApiStore>(context);

    if(_pokeApiStore.pokeAPI == null) {
      _pokeApiStore.fetchPokemonList();
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double statusWidth = MediaQuery.of(context).padding.top;
    double imgSize = 240;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        overflow: Overflow.visible,
        children: <Widget>[

          //Pokebola no canto superior direito
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

                //subtrai status bar
                Container(
                  height: statusWidth,
                ),

                // App bar widget
                AppBarHome(),

                // Pokemon list
                Expanded(
                  child: Container(
                    child: Observer(
                      builder: (BuildContext context) {
                        PokeAPI _pokeAPI = _pokeApiStore.pokeAPI;

                        return _pokeAPI != null ? 

                          AnimationLimiter(
                            child: GridView.builder(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.all(12),
                              addAutomaticKeepAlives: true,
                              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2
                              ),
                              itemCount: _pokeApiStore.pokeAPI.pokemon.length,
                              itemBuilder: (context, index) {

                                Pokemon pokemon = _pokeApiStore.getPokemon(index: index);

                                return AnimationConfiguration.staggeredGrid(
                                  position: index,
                                  duration: const Duration(microseconds: 365), 
                                  columnCount: 2, 
                                  child: ScaleAnimation(
                                    child: GestureDetector(
                                      child: PokeItem(
                                        index: index,
                                        name: pokemon.name,
                                        num: pokemon.num,
                                        types: pokemon.type,
                                      ),
                                      onTap: () {
                                        _pokeApiStore.setCurrentPokemon(index:index);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) => DetailsPage(index: index),
                                            fullscreenDialog: true,
                                          )
                                        );
                                      },
                                    ),
                                  ) 
                                );
                              },
                            ),

                          )


                          // ListView.builder(
                          //   itemCount: _pokeAPI.pokemon.length,
                          //   itemBuilder: (context, index) {
                          //     return ListTile(
                          //       title: Text(_pokeAPI.pokemon[index].name) 
                          //     );
                          //   }
                          // ) 
                          : Center(
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