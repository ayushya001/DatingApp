
class MessageCardModel {
  MessageCardModel({
    required this.image,
    required this.about,
    required this.name,
    required this.createdAt,
    required this.isOnline,
    required this.id,
    required this.lastActive,
    required this.email,
    required this.pushToken,
  });
  late final String image;
  late final String about;
  late final String name;
  late final String createdAt;
  late final bool isOnline;
  late final String id;
  late final String lastActive;
  late final String email;
  late final String pushToken;

  MessageCardModel.fromJson(Map<String, dynamic> json){
    image = json['image'] ?? ''; // Provide a default empty string if 'image' is null
    about = json['about'] ?? '';
    name = json['name'] ?? '';
    createdAt = json['created_At'] ?? '';
    isOnline = json['is_online'] ?? false; // Provide a default value for a bool
    id = json['id'] ?? '';
    lastActive = json['last_active'] ?? '';
    email = json['email'] ?? '';
    pushToken = json['push_token'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image'] = image;
    _data['about'] = about;
    _data['name'] = name;
    _data['created_At'] = createdAt;
    _data['is_online'] = isOnline;
    _data['id'] = id;
    _data['last_active'] = lastActive;
    _data['email'] = email;
    _data['push_token'] = pushToken;
    return _data;
  }
}