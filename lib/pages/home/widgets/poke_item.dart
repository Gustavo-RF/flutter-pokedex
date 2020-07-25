import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/consts/consts_api.dart';
import 'package:pokedex/consts/consts_app.dart';

class PokeItem extends StatelessWidget {
  final String name;
  final int index;
  final Color color;
  final String num;
  final List<String> types;

  Widget setTypes() {
    List<Widget> list = [];
    types.forEach((name) {
      list.add(Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: Color.fromARGB(80, 255, 255, 255),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(name.trim(),
                  style: TextStyle(
                    fontFamily: 'Google',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
          ),
          SizedBox(
            height: 5,
          )
        ],
      ));
    });

    return Column(
      children: list,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  const PokeItem(
      {Key key, this.name, this.index, this.color, this.num, this.types})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: ConstsApi.getColorType(type: types[0]),
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
              // alignment: Alignment.bottomRight,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Pokemon name
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        name,
                        style: TextStyle(
                            fontFamily: 'Google',
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),

                    // Pokemon types
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                      child: setTypes(),
                    ),
                  ],
                ),

                // Pokeball behind pokemon image
                Align(
                  alignment: Alignment.bottomRight,
                  child: Hero(
                    tag: index.toString(),
                    child: Opacity(
                      opacity: 0.2,
                      child: Image.asset(
                        ConstsApp.whitePokeball,
                        height: 80.0,
                        width: 80.0,
                      ),
                    ),
                  ),
                ),

                // Pokemon image
                Align(
                  alignment: Alignment.bottomRight,
                  child: CachedNetworkImage(
                    height: 80.0,
                    width: 80.0,
                    placeholder: (context, uri) => new Container(
                      color: Colors.transparent,
                    ),
                    imageUrl:
                        'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$num.png',
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
