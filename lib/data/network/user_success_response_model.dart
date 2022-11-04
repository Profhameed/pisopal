

/// success : true
/// description : "Data Saved successfully"

class UserSuccessResponseModel {
  UserSuccessResponseModel({
    this.success,
    this.description,
  });

  UserSuccessResponseModel.fromJson(dynamic json) {
    success = json['success'];
    description = json['description'];
  }

  bool? success;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['description'] = description;
    return map;
  }
}
