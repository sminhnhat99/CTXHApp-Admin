class Member {
  List<Data> data;

  Member({this.data});

  Member.fromJson(Map<String, dynamic> json) {
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
  String name;
  String position;
  int kDV;
  String description;
  String role;
  String memberImage;

  Data(
      {this.sId,
      this.name,
      this.position,
      this.kDV,
      this.description,
      this.role,
      this.memberImage});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    position = json['position'];
    kDV = json['KDV'];
    description = json['description'];
    role = json['role'];
    memberImage = json['memberImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['position'] = this.position;
    data['KDV'] = this.kDV;
    data['description'] = this.description;
    data['role'] = this.role;
    data['memberImage'] = this.memberImage;
    return data;
  }
}