import 'package:bloc/bloc.dart';
import 'package:crypto_currency/bloc/converter/converter_bloc.dart';
import 'package:crypto_currency/bloc/crypto/crypto_barrel.dart';
import 'package:crypto_currency/repository/repository.dart';
import 'package:crypto_currency/repository/api_client.dart';
import 'package:crypto_currency/screen/crypto_list_screen.dart';
import 'package:crypto_currency/widgets/drawer_content.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'bloc/crypto_list/crypto_list_bloc.dart';

class SimpleBlocObserver extends BlocObserver {

  @override
  void onTransition(Bloc bloc, Transition transition){
    super.onTransition(bloc, transition);
    print('Transition: $transition');
  }

  @override
  void onEvent(Bloc bloc, Object event){
    super.onEvent(bloc, event);
    print('Event: $event');
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace){
    super.onError(cubit, error, stackTrace);
    print('Error: $error');
    print('Error: $stackTrace');
  }
}

void main() {

  Bloc.observer = SimpleBlocObserver();

  final Repository repository = Repository(
    apiClient: ApiClient(
      httpClient: http.Client()
    )
  );

  runApp(MyApp(
    repository: repository
  ));
}

class MyApp extends StatelessWidget {

  final Repository repository;
  MyApp({Key key,@required this.repository})
    : assert(repository != null), super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CryptoListBloc(repository: repository)..add(FetchCryptoList(limit: '100')),
        ),
        BlocProvider(
          create: (context) => CryptoBloc(repository: repository)..initialState,
        ),
        BlocProvider(
          create: (context) => ConverterBloc(repository: repository)..initialState,
        ),
      ],
      child: MaterialApp(
        title: 'Crypto Price',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          key: scaffoldKey,
          drawer: Drawer(
            child: DrawerContent(),
          ),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xff4b5780),
            leading: menuButton(),
            centerTitle: true,
            title: Text(
              'Crypto Assets',
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          body: CryptoListScreen(),
        ),
      ),
    );
  }


  Widget menuButton(){
    return GestureDetector(
      onTap: (){
        scaffoldKey.currentState.openDrawer();
      },
      child: Container(
        margin: EdgeInsets.only(top: 20, left: 10),
        child: Column(
          children: [
            Container(
              height: 4.5,
              width: 30,
              decoration: BoxDecoration(
                color: Color(0xff6a7196),
                borderRadius: BorderRadius.circular(5)
              ),
            ),
            SizedBox(height: 4),
            Contaimainner(
              height: 4.5,
              width: 45,
              decoration: BoxDecoration(
                  color: Color(0xff6a7196),
                  borderRadius: BorderRadius.circular(5)
              ),
            ),
            SizedBox(height: 4),
            Container(
              height: 4.5,
              width: 30,
              decoration: BoxDecoration(
                  color: Color(0xff6a7196),
                  borderRadius: BorderRadius.circular(5)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
