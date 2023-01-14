import 'dart:convert';

class UserModel {
  final String name;
  final String? photoUrl;

  UserModel({required this.name, this.photoUrl});

  //cria a partir de um map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(name: map['name'], photoUrl: map['photoUrl']);
  }

  // * json.decode pega uma string json e transforma em um map
  // * fromMap cria um Usermodel a partir de um map
  factory UserModel.fromJson(String json) => UserModel.fromMap(jsonDecode(json));

  Map<String, dynamic> tomap() => {
        "name": name,
        "photoUrl": photoUrl,
      };

  String toJson() => jsonEncode(tomap());
}
