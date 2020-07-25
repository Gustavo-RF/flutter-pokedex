import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/consts/consts_app.dart';
import 'package:pokedex/models/pokeapi.dart';
import 'package:pokedex/stores/pokeapi_store.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class DetailsPage extends StatefulWidget {
  final int index;
  final String name;

  DetailsPage({Key key, this.index, this.name}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  PageController _pageController;
  Pokemon _pokemon;
  PokeApiStore _pokeApiStore;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
    _pokeApiStore = GetIt.instance<PokeApiStore>();
    _pokemon = _pokeApiStore.currentPokemon;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48.0),
        child: Observer(builder: (context) {
          return AppBar(
              title: Opacity(
                opacity: 0.0,
                child: Text(
                  _pokemon.name,
                  style: TextStyle(
                      fontFamily: 'Google',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0),
                ),
              ),
              elevation: 0,
              backgroundColor: _pokeApiStore.pokemonColor,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {},
                )
              ],
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ));
        }),
      ),
      body: Stack(
        children: <Widget>[
          Observer(
            builder: (BuildContext context) {
              return Container(
                color: _pokeApiStore.pokemonColor,
              );
            },
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3,
          ),
          SlidingSheet(
            elevation: 0.0,
            cornerRadius: 32.0,
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
              height: 200.0,
              child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    _pokeApiStore.setCurrentPokemon(index: index);
                  },
                  itemCount: _pokeApiStore.pokeAPI.pokemon.length,
                  itemBuilder: (BuildContext context, int index) {
                    Pokemon _pkm = _pokeApiStore.getPokemon(index: index);
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        // TODO set up pokeball animation using simple animations
                        Hero(
                          tag: index.toString(),
                          child: Opacity(
                            opacity: 0.2,
                            child: Image.asset(
                              ConstsApp.whitePokeball,
                              height: 160.0,
                              width: 160.0,
                            ),
                          ),
                        ),
                        Observer(builder: (context) {
                          // TODO animated padding not working ?
                          return AnimatedPadding(
                            duration: Duration(milliseconds: 250),
                            padding: EdgeInsets.all(
                                index == _pokeApiStore.currentPosition ? 0 : 0),
                            child: CachedNetworkImage(
                              height: 160.0,
                              width: 160.0,
                              placeholder: (context, uri) => new Container(
                                color: Colors.transparent,
                              ),
                              // color: (index == _pokeApiStore.currentPosition)
                              //     ? null
                              //     : Colors.black.withOpacity(0.5),
                              imageUrl:
                                  'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${_pkm.num}.png',
                            ),
                          );
                        }),
                      ],
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
