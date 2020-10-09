class CoinInfo {
  Urls urls;
  String logo;
  int id;
  String name;
  String symbol;
  String slug;
  String description;
  String dateAdded;
  List<String> tags;
  String category;

  CoinInfo({
    this.urls,
    this.logo,
    this.id,
    this.name,
    this.symbol,
    this.slug,
    this.description,
    this.dateAdded,
    this.tags,
    this.category
  });

  CoinInfo.fromJson(Map<String, dynamic> json) {
    urls = json['urls'] != null ? new Urls.fromJson(json['urls']) : null;
    logo = json['logo'];
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    slug = json['slug'];
    description = json['description'];
    dateAdded = json['date_added'];
    tags = json['tags'].cast<String>();
    category = json['category'];
  }

}

class Urls {
  List<String> website;
  List<String> technicalDoc;
  List<String> sourceCode;

  Urls({
    this.website,
    this.technicalDoc,
    this.sourceCode
  });

  Urls.fromJson(Map<String, dynamic> json) {
    website = json['website'].cast<String>();
    technicalDoc = json['technical_doc'].cast<String>();
    sourceCode = json['source_code'].cast<String>();
  }
}