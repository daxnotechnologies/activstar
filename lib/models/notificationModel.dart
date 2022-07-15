class NotificationModel {
  String? title;
  String? text;
  String? link;
  bool? read;
  var time;

  NotificationModel({this.title, this.text, this.link, this.read, this.time});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    text = json['text'];
    link = json['link'];
    read = json['read'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['text'] = this.text;
    data['link'] = this.link;
    data['read'] = this.read;
    data['time'] = this.time;
    return data;
  }
}