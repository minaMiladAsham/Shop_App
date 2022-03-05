class ProfileModel {
  late bool status;
  UserData? data;

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = UserData.fromJson(json['data']);
  }
}

class UserData {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
  }

}