import 'package:crypto_currency/bloc/crypto/crypto_barrel.dart';
import 'package:crypto_currency/model/coin_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleCoinScreen extends StatefulWidget {
  final id;
  final price;

  SingleCoinScreen({@required this.id, @required this.price})
      : assert(id != null),
        assert(price != null);

  @override
  _SingleCoinScreenState createState() => _SingleCoinScreenState();
}

class _SingleCoinScreenState extends State<SingleCoinScreen> {
  @override
  void initState() {
    BlocProvider.of<CryptoBloc>(this.context).add(FetchCrypto(id: widget.id));

    super.initState();
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Color(0xff4b5780),
          child:
              BlocBuilder<CryptoBloc, CryptoState>(builder: (context, state) {
            if (state is CryptoEmpty || state is CryptoLoading) {
              return Container(
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (state is CryptoLoaded) {
              return Container(
                child: Column(
                  children: [
                    appBar(state.crypto),
                    SizedBox(height: 25),
                    ListView(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.all(10),
                      children: [
                        coinInfo(state.crypto.urls, state.crypto.dateAdded),
                        SizedBox(height: 25),
                        coinDescription(state.crypto.description)
                      ],
                    ),
                  ],
                ),
              );
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'دریافت اطلاعات با خطا روبرو شد لطفا دوباره امتحان کنید!',
                    style: TextStyle(fontSize: 17, color: Colors.white),
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(height: 10),
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('بازگشت'),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget appBar(CoinInfo item) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(
          height: 100,
          padding: EdgeInsets.only(top: 15, left: 15),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.deepOrangeAccent, Colors.orangeAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, offset: Offset(0, 5), blurRadius: 5)
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(width: 60),
              Image.network(
                'https://s2.coinmarketcap.com/static/img/coins/64x64/${item.id.toString()}.png',
                width: 30,
                height: 30,
                errorBuilder: (context, object, stackTrace) {
                  return Container(
                    width: 64,
                    height: 64,
                  );
                },
              ),
              SizedBox(width: 20),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  item.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 10),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  item.symbol,
                  style: TextStyle(
                      color: Colors.white70, fontSize: 15, height: 1.6),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: -20,
          left: (MediaQuery.of(context).size.width -
                  MediaQuery.of(context).size.width * 0.7) /
              2,
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 5))
                ]),
            child: Center(
              child: Text(
                '\$ ' + widget.price.toStringAsFixed(2),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget coinInfo(Urls urls, String dateAdded) {
    print(urls.technicalDoc);
    return Container(
      decoration: BoxDecoration(
          color: Color(0xff2e3756),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)]),
      child: Column(
        children: [
          cardsHeaderTitle('Coin Info'),
          SizedBox(height: urls.website.isNotEmpty ? 15 : 0),
          urls.website.isNotEmpty
              ? coinInfoItems('Website', urls.website[0])
              : SizedBox(),
          SizedBox(height: urls.technicalDoc.isNotEmpty ? 15 : 0),
          urls.technicalDoc.isNotEmpty
              ? coinInfoItems('Technical Doc', urls.technicalDoc[0])
              : SizedBox(),
          SizedBox(height: urls.sourceCode.isNotEmpty ? 15 : 0),
          urls.sourceCode.isNotEmpty
              ? coinInfoItems('Source Code', urls.sourceCode[0])
              : SizedBox(),
          SizedBox(height: 15),
          coinInfoItems('Date Added', dateAdded.split('T')[0]),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget coinDescription(String desc) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xff2e3756),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)]),
      child: Column(
        children: [
          cardsHeaderTitle('Coin Description'),
          Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              desc,
              style: TextStyle(
                color: Colors.cyanAccent,
                height: 1.5,
                fontSize: 15,
              ),
              textAlign: TextAlign.justify,
            ),
          )
        ],
      ),
    );
  }

  Widget coinInfoItems(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 15),
        Text(
          '$title: ',
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 15),
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (value.contains('http')) {
                _launchURL(value);
              }
            },
            child: Text(
              value,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.deepOrangeAccent,
                  decoration: value.contains('http')
                      ? TextDecoration.underline
                      : TextDecoration.none),
            ),
          ),
        ),
      ],
    );
  }

  Widget cardsHeaderTitle(String title) {
    return Column(
      children: [
        SizedBox(height: 15),
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 20),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 15),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 2,
          color: Colors.white,
        ),
      ],
    );
  }
}
