class categoryModel {
  bool? success;
  List<categoryItems>? items;

  categoryModel({this.success, this.items});

  categoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['items'] != null) {
      items = <categoryItems>[];
      json['items'].forEach((v) {
        items!.add(new categoryItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class categoryItems {
  String? id;
  String? title;

  categoryItems({this.id, this.title});

  categoryItems.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = json['title'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
