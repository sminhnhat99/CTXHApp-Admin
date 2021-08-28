class AddEventResponseModel {
  final int success;
  final String message;

  AddEventResponseModel({this.message, this.success});  
  factory AddEventResponseModel.fromJson(Map<dynamic, dynamic> json){
    return AddEventResponseModel(
      success: json['success'] != null ?json['success'] : '',
      message: json["message"] != null ? json["message"]: "",
    );
  }
}

class AddEventRequestModel {
  String eventName;
  String eventLocation;
  DateTime time;
  AddEventRequestModel({this.eventName, this.eventLocation, this.time});

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map ={
      'eventName':eventName.trim(),
      'eventLocation':eventLocation.trim(),
      'time' : time
    };
    return map;
  } 
}