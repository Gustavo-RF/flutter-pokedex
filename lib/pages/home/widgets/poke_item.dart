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

  const PokeItem({Key key, this.name, this.index, this.color, this.num, this.types}) : super(key: key);

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
            children: <Widget> [
              Align(
                alignment: Alignment.bottomRight,
                child: Opacity(
                  opacity: 0.2,
                    child: Image.asset(
                    ConstsApp.whitePokeball,
                    height: 96.0,
                    width: 96.0,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: CachedNetworkImage(
                  height: 96.0,
                  width: 96.0,
                  placeholder: (context, uri) => new Container( color: Colors.transparent,),
                  imageUrl: 'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$num.png',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'Google',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
}