class newsModel {
  List<Items>? items;

  newsModel({this.items});

  newsModel.fromJson(Map<String, dynamic> json) {
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
  int? iD;
  String? title;
  String? fullDescription;
  String? dDescription;
  String? excerpt;
  String? excerpts;
  String? link;
  String? image;
  String? publishedDate;
  List<String>? category;

  Items(
      {this.iD,
      this.title,
      this.fullDescription,
      this.dDescription,
      this.excerpt,
      this.excerpts,
      this.link,
      this.image,
      this.publishedDate,
      this.category});

  Items.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    title = json['title'];
    fullDescription = json['full_description'];
    dDescription = json['d-description'];
    excerpt = json['excerpt'];
    excerpts = json['excerpts'];
    link = json['link'];
    image = json['image'];
    publishedDate = json['published_date'];
    category = json['category'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['title'] = this.title;
    data['full_description'] = this.fullDescription;
    data['d-description'] = this.dDescription;
    data['excerpt'] = this.excerpt;
    data['excerpts'] = this.excerpts;
    data['link'] = this.link;
    data['image'] = this.image;
    data['published_date'] = this.publishedDate;
    data['category'] = this.category;
    return data;
  }
}
