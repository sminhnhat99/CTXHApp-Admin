class LoginResponseModel {
  final int success;
  final String message;
  final String token;

  LoginResponseModel({this.success, this.message, this.token});

  factory LoginResponseModel.fromJson(Map <dynamic, dynamic> json) {
    return LoginResponseModel(
      success: json["success"] != null ? json["success"] : "",
      message: json["message"] != null ? json["message"] : "",
      token: json["token"] != null ? json["token"] : "",
    );
  }
}

class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel({this.email, this.password});

  Map<String, dynamic>toJson(){
    Map<String, dynamic> map = {
      'email': email.trim(),
      'password': password.trim(),
    };

    return map;
  }
}