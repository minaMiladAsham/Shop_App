class FavoritesPostModel {
  late bool status;
  late String message;

  FavoritesPostModel.fromJson(Map<String , dynamic> json){
    status = json['status'];
    message = json['message'];
  }
}