import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class CryptocurrencyModel extends Equatable{

  final id;
  final String name;
  final String symbol;
  final String slug;
  final numMarketPairs;
  final String dateAdded;
  final List<String> tags;
  final maxSupply;
  final circulatingSupply;
  final totalSupply;
  final PlatformModel platform;
  final cmcRank;
  final String lastUpdated;
  final Quote quote;

  CryptocurrencyModel(
      {this.id,
        this.name,
        this.symbol,
        this.slug,
        this.numMarketPairs,
        this.dateAdded,
        this.tags,
        this.maxSupply,
        this.circulatingSupply,
        this.totalSupply,
        this.platform,
        this.cmcRank,
        this.lastUpdated,
        this.quote});

  CryptocurrencyModel.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    name = json['name'],
    symbol = json['symbol'],
    slug = json['slug'],
    numMarketPairs = json['num_market_pairs'],
    dateAdded = json['date_added'],
    tags = json['tags'].cast<String>(),
    maxSupply = json['max_supply'],
    circulatingSupply = json['circulating_supply'],
    totalSupply = json['total_supply'],
    platform = json['platform'] != null ? new PlatformModel.fromJson(json['platform']) : null,
    cmcRank = json['cmc_rank'],
    lastUpdated = json['last_updated'],
    quote = json['quote'] != null ? new Quote.fromJson(json['quote']) : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['slug'] = this.slug;
    data['num_market_pairs'] = this.numMarketPairs;
    data['date_added'] = this.dateAdded;
    data['tags'] = this.tags;
    data['max_supply'] = this.maxSupply;
    data['circulating_supply'] = this.circulatingSupply;
    data['total_supply'] = this.totalSupply;
    data['platform'] = this.platform;
    data['cmc_rank'] = this.cmcRank;
    data['last_updated'] = this.lastUpdated;
    if (this.quote != null) {
      data['quote'] = this.quote.toJson();
    }
    return data;
  }

  fromJsonToList(List<dynamic> data) {
    List<CryptocurrencyModel> list = [];

    data.forEach((element) {
      list.add(CryptocurrencyModel.fromJson(element));
    });

    return list;
  }

  @override
  List<Object> get props => [
    id,
    name,
    symbol,
    slug,
    numMarketPairs,
    dateAdded,
    tags,
    maxSupply,
    circulatingSupply,
    totalSupply,
    platform,
    cmcRank,
    lastUpdated,
    quote
  ];
}

class Quote extends Equatable{

  final USD uSD;

  Quote({this.uSD});

  Quote.fromJson(Map<String, dynamic> json) :
    uSD = json['USD'] != null ? new USD.fromJson(json['USD']) : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.uSD != null) {
      data['USD'] = this.uSD.toJson();
    }
    return data;
  }

  @override
  List<Object> get props => [uSD];
}

class USD extends Equatable{

  final price;
  final volume24h;
  final percentChange1h;
  final percentChange24h;
  final percentChange7d;
  final marketCap;
  final String lastUpdated;

  USD(
      {this.price,
        this.volume24h,
        this.percentChange1h,
        this.percentChange24h,
        this.percentChange7d,
        this.marketCap,
        this.lastUpdated});

  USD.fromJson(Map<String, dynamic> json) :
    price = json['price'],
    volume24h = json['volume_24h'],
    percentChange1h = json['percent_change_1h'],
    percentChange24h = json['percent_change_24h'],
    percentChange7d = json['percent_change_7d'],
    marketCap = json['market_cap'],
    lastUpdated = json['last_updated'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['volume_24h'] = this.volume24h;
    data['percent_change_1h'] = this.percentChange1h;
    data['percent_change_24h'] = this.percentChange24h;
    data['percent_change_7d'] = this.percentChange7d;
    data['market_cap'] = this.marketCap;
    data['last_updated'] = this.lastUpdated;
    return data;
  }

  @override
  List<Object> get props => [
    price,
    volume24h,
    percentChange1h,
    percentChange24h,
    percentChange7d,
    marketCap,
    lastUpdated
  ];
}

class PlatformModel extends Equatable{

  final id;
  final String name;
  final String symbol;
  final String slug;
  final String tokenAddress;

  PlatformModel(
      {this.id, this.name, this.symbol, this.slug, this.tokenAddress});

  PlatformModel.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    name = json['name'],
    symbol = json['symbol'],
    slug = json['slug'],
    tokenAddress = json['token_address'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['slug'] = this.slug;
    data['token_address'] = this.tokenAddress;
    return data;
  }

  @override
  List<Object> get props => [id, name, symbol, slug, tokenAddress];
}
