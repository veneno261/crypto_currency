class Auth {
  final String _mainUrl = 'https://pro-api.coinmarketcap.com';
  final String _token = '3e186af6-5854-4074-a2c7-ce0ff85604cd';

  String get token => _token;

  String get urlCurrency => '$_mainUrl/v1/cryptocurrency';

  String get urlExchanges => '$_mainUrl/v1/exchange';

  String get urlTools => '$_mainUrl/v1//tools';
}