class TestimonialModal {
  List<Items>? items;

  TestimonialModal({this.items});

  TestimonialModal.fromJson(List<dynamic> json) {
    if (json != null) {
      items = <Items>[];
      json.forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  List<dynamic> toJson() {
    List<dynamic> data = [];
    if (this.items != null) {
      data = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? iD;
  String? title;
  String? description;
  String? fullDescription;
  String? link;
  String? image;
  int? stickyDisplay;
  String? endTime;

  Items(
      {this.iD,
      this.title,
      this.description,
      this.fullDescription,
      this.link,
      this.image,
      this.stickyDisplay,
      this.endTime});

  Items.fromJson(Map<String, dynamic> json) {
    print(json);
    iD = json['ID'];
    title = json['title'];
    description = json['description'];
    fullDescription = json['full_description'];
    link = json['link'];
    image = json['image'];
    stickyDisplay = json['sticky_display'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['title'] = this.title;
    data['description'] = this.description;
    data['full_description'] = this.fullDescription;
    data['link'] = this.link;
    data['image'] = this.image;
    data['sticky_display'] = this.stickyDisplay;
    data['end_time'] = this.endTime;
    return data;
  }
}
