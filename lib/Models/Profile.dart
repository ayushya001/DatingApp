
class ProfileModel {
  ProfileModel({
    required this.uid,
    required this.name,
    required this.distance,
    required this.image,
    required this.isOnline,
    required this.lastActive,
    required this.pushToken,
  });
  late final String uid;
  late final String name;
  late final String distance;
  late final String image;
  late final bool isOnline;
  late final String lastActive;
  late final String pushToken;

  ProfileModel.fromJson(Map<String, dynamic> json){
    uid = json['uid']?? '';
    name = json['name']?? '';
    distance = json['distance']?? '';
    image = json['image']?? '';
    isOnline = json['isOnline']?? '';
    lastActive = json['lastActive']?? '';
    pushToken = json['pushToken']?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['uid'] = uid;
    _data['name'] = name;
    _data['distance'] = distance;
    _data['image'] = image;
    _data['isOnline'] = isOnline;
    _data['lastActive'] = lastActive;
    _data['pushToken'] = pushToken;
    return _data;
  }
}

