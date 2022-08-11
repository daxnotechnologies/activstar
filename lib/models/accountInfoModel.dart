class UserAccountInfo {
  bool? success;
  String? email;
  String? name;
  Group? group;
  String? balance;
  String? provision;
  Level? level;
  Team? team;
  Share? share;
  Function? function;

  UserAccountInfo({this.success, this.email, this.name, this.group, this.balance, this.provision, this.level, this.team, this.share, this.function});

  UserAccountInfo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    email = json['email'];
    name = json['name'];
    group = json['group'] != null ? new Group.fromJson(json['group']) : null;
    balance = json['balance'];
    provision = json['provision'];
    level = json['level'] != null ? new Level.fromJson(json['level']) : null;
    team = json['team'] != null ? new Team.fromJson(json['team']) : null;
    share = json['share'] != null ? new Share.fromJson(json['share']) : null;
    function = json['function'] != null ? new Function.fromJson(json['function']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['email'] = this.email;
    data['name'] = this.name;
    if (this.group != null) {
      data['group'] = this.group!.toJson();
    }
    data['balance'] = this.balance;
    data['provision'] = this.provision;
    if (this.level != null) {
      data['level'] = this.level!.toJson();
    }
    if (this.team != null) {
      data['team'] = this.team!.toJson();
    }
    if (this.share != null) {
      data['share'] = this.share!.toJson();
    }
    if (this.function != null) {
      data['function'] = this.function!.toJson();
    }
    return data;
  }
}

class Group {
  int? id;

  Group({this.id});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}

class Level {
  int? id;
  int? points;
  Closest? closest;

  Level({this.id, this.points, this.closest});

  Level.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    points = json['points'];
    closest = json['closest'] != null ? new Closest.fromJson(json['closest']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['points'] = this.points;
    if (this.closest != null) {
      data['closest'] = this.closest!.toJson();
    }
    return data;
  }
}

class Closest {
  Null? level;
  Null? remainingPoints;

  Closest({this.level, this.remainingPoints});

  Closest.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    remainingPoints = json['remaining_points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level'] = this.level;
    data['remaining_points'] = this.remainingPoints;
    return data;
  }
}


class Team {
int? count;

Team({this.count});

Team.fromJson(Map<String, dynamic> json) {
count = json['count'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['count'] = this.count;
return data;
}
}

class Rank {
String? id;
String? amount;
String? bonus;
int? level;
int? total;
Next? next;
int? missing;

Rank({this.id, this.amount, this.bonus, this.level, this.total, this.next, this.missing});

Rank.fromJson(Map<String, dynamic> json) {
id = json['id'];
amount = json['amount'];
bonus = json['bonus'];
level = json['level'];
total = json['total'];
next = json['next'] != null ? new Next.fromJson(json['next']) : null;
missing = json['missing'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['id'] = this.id;
data['amount'] = this.amount;
data['bonus'] = this.bonus;
data['level'] = this.level;
data['total'] = this.total;
if (this.next != null) {
data['next'] = this.next!.toJson();
}
data['missing'] = this.missing;
return data;
}
}

class Next {
String? id;
String? amount;
String? bonus;
int? level;

Next({this.id, this.amount, this.bonus, this.level});

Next.fromJson(Map<String, dynamic> json) {
id = json['id'];
amount = json['amount'];
bonus = json['bonus'];
level = json['level'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['id'] = this.id;
data['amount'] = this.amount;
data['bonus'] = this.bonus;
data['level'] = this.level;
return data;
}
}

class Share {
String? facebook;
String? twitter;

Share({this.facebook, this.twitter});

Share.fromJson(Map<String, dynamic> json) {
facebook = json['facebook'];
twitter = json['twitter'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['facebook'] = this.facebook;
data['twitter'] = this.twitter;
return data;
}
}

class Function {
bool? hasInviteFriend;

Function({this.hasInviteFriend});

Function.fromJson(Map<String, dynamic> json) {
hasInviteFriend = json['hasInviteFriend'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['hasInviteFriend'] = this.hasInviteFriend;
return data;
}
}

