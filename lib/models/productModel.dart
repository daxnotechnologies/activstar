class productModel {
  List<Items>? items;

  productModel({this.items});

  productModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? title;
  String? url;
  String? imageUrl;
  String? priceWithVat;
  String? priceWithoutVat;

  Items(
      {this.title,
        this.url,
        this.imageUrl,
        this.priceWithVat,
        this.priceWithoutVat});

  Items.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
    imageUrl = json['image_url'];
    priceWithVat = json['price_with_vat'];
    priceWithoutVat = json['price_without_vat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['url'] = this.url;
    data['image_url'] = this.imageUrl;
    data['price_with_vat'] = this.priceWithVat;
    data['price_without_vat'] = this.priceWithoutVat;
    return data;
  }
}
