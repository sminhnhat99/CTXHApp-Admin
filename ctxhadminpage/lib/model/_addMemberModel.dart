class AddMemberResponseModel {
  final int success;
  final String message;

  AddMemberResponseModel({this.success, this.message});
  factory AddMemberResponseModel.fromJson(Map<dynamic, dynamic> json){
    return AddMemberResponseModel(
      success: json['success'] != null ?json['success'] : '',
      message: json["message"] != null ? json["message"]: "",
    );
  }
}

class AddMemberRequestModel {
  String name;
  String position;
  int KDV;
  String description;
  String role;
  String memberImage;

  AddMemberRequestModel({this.name, this.position, this.KDV, this.description, this.role, this.memberImage});

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {
      'name' : name.trim(),
      'position' : position.trim(),
      'KDV': KDV,
      'description' : description.trim(),
      'role': role.trim(),
      'memberImage': memberImage.trim()
    };
    return map;
  }
}