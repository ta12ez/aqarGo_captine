class FollowersModel {
  FollowersModel({
    required this.officeId,
    required this.followersCount,
    required this.followers,
  });
  late final int officeId;
  late final int followersCount;
  late final List<Followers> followers;

  FollowersModel.fromJson(Map<String, dynamic> json){
    officeId = json['office_id'];
    followersCount = json['followers_count'];
    followers = List.from(json['followers']).map((e)=>Followers.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['office_id'] = officeId;
    _data['followers_count'] = followersCount;
    _data['followers'] = followers.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Followers {
  Followers({
    required this.userId,
    required this.FirstName,
    required this.LastName,
    required this.email,
    required this.image,
    required this.PhoneNumber,
    required this.pivot,
  });
  late final int userId;
  late final String FirstName;
  late final String LastName;
  late final String email;
  late final dynamic image;
  late final String PhoneNumber;
  late final Pivot pivot;

  Followers.fromJson(Map<String, dynamic> json){
    userId = json['user_id'];
    FirstName = json['FirstName'];
    LastName = json['LastName'];
    email = json['email'];
    image = json['image'];
    PhoneNumber = json['PhoneNumber'];
    pivot = Pivot.fromJson(json['pivot']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_id'] = userId;
    _data['FirstName'] = FirstName;
    _data['LastName'] = LastName;
    _data['email'] = email;
    _data['image'] = image;
    _data['PhoneNumber'] = PhoneNumber;
    _data['pivot'] = pivot.toJson();
    return _data;
  }
}

class Pivot {
  Pivot({
    required this.officeId,
    required this.userId,
    this.createdAt,
  });
  late final int officeId;
  late final int userId;
  late final Null createdAt;

  Pivot.fromJson(Map<String, dynamic> json){
    officeId = json['office_id'];
    userId = json['user_id'];
    createdAt = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['office_id'] = officeId;
    _data['user_id'] = userId;
    _data['created_at'] = createdAt;
    return _data;
  }
}