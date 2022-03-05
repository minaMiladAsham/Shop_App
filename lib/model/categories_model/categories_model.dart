class CategoriesModel {
  late bool status;
  DataModel? data;

  CategoriesModel.fromJson(Map<String , dynamic> json){
    status = json['status'];
    data = DataModel.fromJson(json['data']);
  }
}

class DataModel
{
  List<CategoriesData> categoriesList =[];

  DataModel.fromJson(Map<String,dynamic> json){
    json['data'].forEach((element){
      categoriesList.add(CategoriesData.fromJson(element));
    });
  }
}

class CategoriesData{
  late int id;
  late String name;
  late String image;

  CategoriesData.fromJson(Map<String , dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}