class UserModel {
  String? name;
  String? email;
  String? city;
  String? id;

  UserModel({this.name, this.email, this.city, this.id});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    city = json['city'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['city'] = this.city;
    data['id'] = this.id;
    return data;
  }
}
