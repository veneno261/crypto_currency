import 'package:crypto_currency/screen/convert_calculator_screen.dart';
import 'package:crypto_currency/screen/crypto_list_screen.dart';
import 'package:flutter/material.dart';

class DrawerContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff4b5780),
      child: ListView(
        children: [
          ListTile(
            title: Text(
              'Top 1000 Assets',
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(Icons.list),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CryptoListScreen(limit: '1000')
              ));
            },
          ),
          ListTile(
            title: Text(
              'Convert Calculator',
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(Icons.cached),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ConvertScreen()
              ));
            },
          ),
        ],
      ),
    );
  }
}
