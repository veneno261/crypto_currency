import 'package:crypto_currency/bloc/converter/converter_bloc.dart';
import 'package:crypto_currency/bloc/crypto_list/crypto_list_bloc.dart';
import 'package:crypto_currency/model/barrel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConvertScreen extends StatefulWidget {
  @override
  _ConvertScreenState createState() => _ConvertScreenState();
}

class _ConvertScreenState extends State<ConvertScreen> {

  TextEditingController controller = TextEditingController();

  List<Widget> dropDowns;
  List<CryptocurrencyModel> items;
  List<Map<String, dynamic>> fiatItems;
  bool isReverse;
  String cryptoName;
  String cryptoSymbol;
  int fiatId;
  dynamic value;
  dynamic fiatValue;

  @override
  void initState() {

    items = BlocProvider.of<CryptoListBloc>(context).state.items;
    value = items.first.id;
    cryptoName = items.first.name;
    cryptoSymbol = items.first.symbol;

    isReverse = false;

    fiatItems = [
      {
        'name':'Iranian Rial "﷼" (IRR)',
        'symbol': 'IRR',
        'id': 3544
      },
      {
        'name':'United States Dollar "\$" (USD)',
        'symbol': 'USD',
        'id': 2781
      },
      {
        'name':'Australian Dollar "\$" (AUD)',
        'symbol': 'AUD',
        'id': 2782
      },
      {
        'name':'Canadian Dollar "\$" (CAD)',
        'symbol': 'CAD',
        'id': 2784
      },
      {
        'name':'Chinese Yuan "¥" (CNY)',
        'symbol': 'CNY',
        'id': 2787
      },
      {
        'name':'Japanese Yen "¥" (JPY)',
        'symbol': 'JPY',
        'id': 2797
      },
      {
        'name':'Euro "€" (EUR)',
        'symbol': 'EUR',
        'id': 2790
      },
      {
        'name':'Indian Rupee "₹" (INR)',
        'symbol': 'INR',
        'id': 2796
      },
    ];
    fiatValue = 'USD';
    fiatId = 2781;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    dropDowns = [
      cryptoListDropDown(),
      swapButton(),
      fiatListDropDown()
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff4b5780),
        elevation: 0,
      ),
      body: Container(
        color: Color(0xff4b5780),
        width: double.maxFinite,
        height: double.maxFinite,
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xff2e3756),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                cardsHeaderTitle('Converter'),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: TextFormField(
                            controller: controller,
                            style: TextStyle(
                              color: Colors.white
                            ),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Amount',
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.white54
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                  color: Colors.white
                                )
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                  color: Colors.white
                                )
                              )
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: (){
                          FocusScope.of(context).requestFocus(FocusNode());
                          BlocProvider.of<ConverterBloc>(context).add(FetchConvertPrice(
                            id: isReverse ? fiatId.toString() : value.toString(),
                            amount: controller.text,
                            target: isReverse ? cryptoSymbol : fiatValue
                          ));
                        },
                        icon: Icon(Icons.cached),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ListView(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  physics: NeverScrollableScrollPhysics(),
                  reverse: isReverse,
                  shrinkWrap: true,
                  children: [
                    cryptoListDropDown(),
                    swapButton(),
                    fiatListDropDown()
                  ],
                ),
                BlocBuilder<ConverterBloc, ConverterState>(
                  builder: (context, state){

                    if(state is ConverterLoading){
                      return Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    if(state is ConverterLoaded && controller.text != ''){
                      return Column(
                        children: [
                          SizedBox(height: 20),
                          Text(
                            controller.text.toString() + ' ' + (isReverse ? fiatValue : cryptoName),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                            ),
                          ),
                          Text(
                            '=',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange
                            ),
                          ),
                          Text(
                            state.price.toStringAsFixed(isReverse ? 10 : 2) + ' ' + (isReverse ? cryptoName : fiatValue),
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white
                            ),
                          ),
                        ],
                      );
                    }

                    return Container();
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
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

  Widget cryptoListDropDown() {
    return SizedBox(
      width: MediaQuery.of(this.context).size.width * 0.8,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: Colors.white
            )
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            value: value,
            dropdownColor: Colors.indigo,
            items: items.sublist(0, 99).map((element) => DropdownMenuItem(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Image.network(
                      'https://s2.coinmarketcap.com/static/img/coins/64x64/${element.id.toString()}.png',
                      width: 25,
                      height: 25,
                      errorBuilder: (context, object, stackTrace){
                        return Container(
                          width: 25,
                          height: 25,
                        );
                      },
                    ),
                    SizedBox(width: 10),
                    Text(
                      element.name,
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ],
                ),
              ),
              value: element.id,
            )).toList(),
            onChanged: (newVal){
              BlocProvider.of<ConverterBloc>(context).add(ClearConvertPrice());
              cryptoName = items.where((element) => element.id == newVal).first.name;
              cryptoSymbol = items.where((element) => element.id == newVal).first.symbol;
              setState(() {
                value = newVal;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget fiatListDropDown() {
    return SizedBox(
      width: MediaQuery.of(this.context).size.width * 0.8,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: Colors.white
            )
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            value: fiatValue,
            dropdownColor: Colors.indigo,
            items: fiatItems.map((element) => DropdownMenuItem(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  element['name'],
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              ),
              value: element['symbol'],
            )).toList(),
            onChanged: (newVal){
              BlocProvider.of<ConverterBloc>(context).add(ClearConvertPrice());
              setState(() {
                fiatValue = newVal;
                fiatId = fiatItems.where((element) => element['symbol'] == newVal).first['id'];
              });
            },
          ),
        ),
      ),
    );
  }

  Widget swapButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: (){
            BlocProvider.of<ConverterBloc>(context).add(ClearConvertPrice());
            setState(() {
              isReverse = !isReverse;
            });
          },
          child: Container(
            width: 50,
            height: 50,
            margin: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.deepOrangeAccent
            ),
            child: Icon(Icons.swap_horiz),
          ),
        ),
      ],
    );
  }
}
