class CategorieModel {
  int? id;
  String? name;

  CategorieModel({this.id, this.name});

  CategorieModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
