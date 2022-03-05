class RegisterModel
{
  late bool status ;
  String? message ;
  UserData? data ;

  RegisterModel.fromJson(Map<String ,dynamic> json )
  {
    status = json['status'] ;
    message = json['message'] ;
    data = json['data']!= null? UserData.fromJson(json['data']) :null ;
  }
}

class UserData
{
  late int id ;
  late String name ;
  late String email ;
  late String phone ;
  late String image ;
  int? point ;
  int? credit ;
  String? token ;

  UserData.fromJson(Map<String , dynamic>? json)
  {
    id = json!['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    point = json['point'];
    credit = json['credit'];
    token = json['token'];
  }
}





