
class MatchRequestModel{

  late final String receiverid;

  MatchRequestModel(this.receiverid);

  MatchRequestModel.fromJson(Map<String, dynamic> json){
    receiverid = json['ReceiverId'].toString();



  }
}