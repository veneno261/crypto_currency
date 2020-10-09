import 'package:crypto_currency/bloc/crypto_list/crypto_list_bloc.dart';
import 'package:crypto_currency/model/barrel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'single_coin_screen.dart';

class CryptoListScreen extends StatefulWidget {

  final String limit;
  CryptoListScreen({this.limit});

  @override
  _CryptoListState createState() => _CryptoListState();
}

class _CryptoListState extends State<CryptoListScreen> {

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    if(widget.limit != null)
      BlocProvider.of<CryptoListBloc>(context).add(FetchCryptoList(limit: '1000'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff4b5780),
      margin: EdgeInsets.only(top: widget.limit != null ? 25 : 0),
      child: BlocBuilder<CryptoListBloc, CryptoListState>(
        builder: (context, state) {

          if(state.status == AdvertiseStatus.initial){
            return Center(child: CircularProgressIndicator());
          }

          if(state.items.isEmpty){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text('محتوایی جهت نمایش وجود ندارد')),
                SizedBox(height: 10),
                RaisedButton(
                  onPressed: (){
                    BlocProvider.of<CryptoListBloc>(this.context).add(FetchCryptoList(limit: '50'));
                  },
                  child: Text('تلاش مجدد'),
                )
              ],
            );
          }

          return ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.only(right: 5, left: 5, top: 20),
            itemCount: state.items.length,
            itemBuilder: (BuildContext context, int index) {

              if(index == 0)
                return firstTileHighLight(state.items[index]);

              return cryptoListTile(state.items[index]);

            },
          );
        }
      ),
    );
  }


  Widget firstTileHighLight(CryptocurrencyModel item) {
    return GestureDetector(
      onTap: (){
        Navigator.of(this.context).push(MaterialPageRoute(
          builder: (context) => SingleCoinScreen(
            id: item.id,
            price: item.quote.uSD.price
          ),
        ));
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [Color(0xff25ccfc), Color(0xff5c9bd8)]
            )
          ),
          child: Row(
            children: [
              SizedBox(width: 20),
              loadIcon(item.id, first: true),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        fullName(item.name, first: true),
                        SizedBox(width: 10),
                        nickName(item.symbol, first: true)
                      ],
                    ),
                    lastChange(
                      item.quote.uSD.percentChange24h,
                      item.quote.uSD.percentChange7d,
                      first: true
                    ),
                    price(item.quote.uSD.price, first: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget cryptoListTile(CryptocurrencyModel item) {
    return GestureDetector(
      onTap: (){
        Navigator.of(this.context).push(MaterialPageRoute(
          builder: (context) => SingleCoinScreen(
            id: item.id,
            price: item.quote.uSD.price
          ),
        ));
      },
      child: Card(
        color: Color(0xff2e3756),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        child: Container(
          height: 60,
          child: Row(
            children: [
              SizedBox(width: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.43,
                child: Row(
                  children: [
                    loadIcon(item.id),
                    SizedBox(width: 10),
                    fullName(item.name),
                    SizedBox(width: 10),
                    nickName(item.symbol)
                  ],
                ),
              ),
              lastChange(item.quote.uSD.percentChange24h, item.quote.uSD.percentChange7d),
              SizedBox(width: 10),
              price(item.quote.uSD.price),
              SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget loadIcon(id, {bool first = false}) {
    return Image.network(
      'https://s2.coinmarketcap.com/static/img/coins/64x64/${id.toString()}.png',
      width: first ? 64 : 25,
      height: first ? 64 : 25,
      errorBuilder: (context, object, stackTrace){
        return Container(
          width: first ? 64 : 25,
          height: first ? 64 : 25,
        );
      },
    );
  }


  Widget fullName(String name, {bool first = false}) {
    return Text(
      name.length > 9 ? name.substring(0, 9) + '...' : name,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: first ? 25 : 15
      ),
    );
  }


  Widget nickName(String name, {bool first = false}) {
    return Text(
      name ?? '',
      style: TextStyle(
        color: Colors.white54,
        fontSize: first ? 15 : 12
      ),
    );
  }


  Widget price(price, {bool first = false}) {
    return Expanded(
      child: Text(
        '\$ ' + price.toStringAsFixed(2),
        style: TextStyle(
          color: first ? Colors.black87 : Colors.white,
          fontSize: first ? 20 : 15
        ),
        textAlign: TextAlign.right,
      ),
    );
  }


  Widget lastChange(change1d, change7d, {bool first = false}) {
    return Expanded(
      child: first ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          oneDayChange(change1d, first: true),
          SizedBox(width: 20),
          sevenDayChange(change7d, first: true),
        ],
      ) : Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          oneDayChange(change1d),
          sevenDayChange(change7d),
        ],
      ),
    );
  }


  Widget oneDayChange(change1d, {bool first = false}) {
    return Text(
      '1d : ' + change1d.toStringAsFixed(2) + '%',
      style: TextStyle(
        color: first ? Colors.white : Colors.white54,
        fontSize: first ? 15 : 11
      ),
    );
  }


  Widget sevenDayChange(change7d, {bool first = false}) {
    return Text(
      '7d : ' + change7d.toStringAsFixed(2) + '%',
      style: TextStyle(
        color: first ? Colors.white : Colors.white54,
        fontSize: first ? 15 : 11
      ),
    );
  }

}
