
class MessegesModel {
  MessegesModel({
    required this.fromid,
    required this.toid,
    required this.msg,
    required this.read,
    required this.sent,
    required this.type,
  });
  late final String fromid;
  late final String toid;
  late final String msg;
  late final String read;
  late final String sent;
  late final Type type;

  MessegesModel.fromJson(Map<String, dynamic> json){
    fromid = json['fromid'].toString();
    toid = json['toid'].toString();
    msg = json['msg'].toString();
    read = json['read'].toString();
    sent = json['sent'].toString();
    type = json['type'].toString() == Type.image.name ? Type.image : Type.text ;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['fromid'] = fromid;
    _data['toid'] = toid;
    _data['msg'] = msg;
    _data['read'] = read;
    _data['sent'] = sent;
    _data['type'] = type.name;
    return _data;
  }
}

enum Type{
  text,image
}