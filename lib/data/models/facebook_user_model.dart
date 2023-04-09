class FaceBookUserModel {
  FaceBookUserModel({this.name, this.email, this.id, this.picture});

  factory FaceBookUserModel.fromJson(Map json) => FaceBookUserModel(
        name: json['name'],
        email: json['email'],
        id: json['id'],
        picture: json['picture']['data']['url'],
      );

  String? name;
  String? email;
  String? id;
  String? picture;
}
