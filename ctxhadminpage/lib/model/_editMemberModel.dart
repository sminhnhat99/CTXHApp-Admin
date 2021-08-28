class EditMemberResponseModel {
  final int success;
  final String message;

  EditMemberResponseModel({this.success, this.message});
  factory EditMemberResponseModel.fromJson(Map<dynamic, dynamic> json){
    return EditMemberResponseModel(
      success: json['success'] != null ?json['success'] : '',
      message: json["message"] != null ? json["message"]: "",
    );
  }
}

class EditMemberRequestModel {
  String name;
  String position;
  int KDV;
  String description;
  String role;
  String memberImage;

  EditMemberRequestModel({this.name, this.position, this.KDV, this.description, this.role, this.memberImage});

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {
      'name' : name.trim(),
      'position' : position.trim(),
      'KDV': KDV,
      'description' : description.trim(),
      'role': role,
      'memberImage': memberImage.trim()
    };
    return map;
  }
}