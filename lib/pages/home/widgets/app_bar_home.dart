import 'package:flutter/material.dart';

class AppBarHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[

          // hamburguer button
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    right: 5.0
                  ),
                  child: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: (){},
                  ),
                )
              ],
            ),
          ),

          // page title
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0
                ),
                child: Text(
                  'Pokedex',
                  style: TextStyle(
                    fontFamily: 'Google',
                    fontWeight: FontWeight.bold,
                    fontSize: 28.0
                  ),
                ),
              )
            ],
          )
          
        ],
      ),
      height: 120,
      // color: Color.fromARGB(200, 240, 240, 240),
    );
  }
}