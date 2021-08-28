class Event {
  List<Data> data;

  Event({this.data});

  Event.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      // ignore: deprecated_member_use
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String sId;
  String eventName;
  String eventLocation;
  DateTime time;

  Data({this.sId, this.eventName, this.eventLocation, this.time});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    eventName = json['eventName'];
    eventLocation = json['eventLocation'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['eventName'] = this.eventName;
    data['eventLocation'] = this.eventLocation;
    data['time'] = this.time;
    return data;
  }
}