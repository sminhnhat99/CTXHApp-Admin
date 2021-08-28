import 'dart:io';

import 'package:ctxhadminpage/api_Service/config.dart';
import 'package:ctxhadminpage/model/_addEventModel.dart';
import 'package:ctxhadminpage/model/_addMemberModel.dart';
import 'package:ctxhadminpage/model/_deleteMemberModel.dart';
import 'package:ctxhadminpage/model/_editMemberModel.dart';
import 'package:ctxhadminpage/model/_loginModel.dart';
import 'package:ctxhadminpage/model/_readEventModel.dart';
import 'package:ctxhadminpage/model/_readMemberModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class APIService {
  // Login

  Future<LoginResponseModel> login (LoginRequestModel loginRequestModel) async {
    String url = Config.url + Config.login;

    final response = await http.post(url, body: loginRequestModel.toJson());
    if(response.statusCode == 200 || response.statusCode == 201) {
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      return LoginResponseModel.fromJson(json.decode(response.body));
    }
  }

  Future<Member> listMember(String token, int page) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    String url = Config.url + Config.getMember + '$page';
    
    final response = await http.get(url, headers: headers);
    if(response.statusCode == 200 || response.statusCode == 401){
      return Member.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<AddMemberResponseModel> addMember(AddMemberRequestModel addMemberRequestModel, String token) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    String url = Config.url + Config.addMember;
    final body = jsonEncode(addMemberRequestModel);
    final response = await http.post(url,headers: headers, body: body);
    if(response.statusCode == 200){
      return AddMemberResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  } 
  
  Future<Member> searchMember(String token, String name, int chooseType) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader : 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    String url;
    if(chooseType == 1) {
      url = Config.url + Config.searchMemberByName + name;
    }
    if(chooseType == 2) {
      url = Config.url + Config.searchMemberByPosition + name;
    }
    if(chooseType == 3) {
      url = Config.url + Config.searchMemberByKhoaDoiVien + name;
    }
    if(chooseType == 4) {
      url = Config.url + Config.searchMemberByRole + name;
    }

    final response = await http.get(url, headers: headers);
    if(response.statusCode == 200) {
      return Member.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<DeleteMember> deleteMember(String token, String memberId) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };
    String url = Config.url + Config.deleteMember + memberId;
    
    final response = await http.delete(url, headers: headers);
    if(response.statusCode == 200){
      return DeleteMember.fromJson(json.decode(response.body));
    } else {
      return DeleteMember.fromJson(json.decode(response.body));
    }
  }

  Future<EditMemberResponseModel> editMember (EditMemberRequestModel editMemberRequestModel,String token, String memberId) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };
    final body = jsonEncode(editMemberRequestModel.toJson());
    String url = Config.url + Config.editMember + memberId;
    final response = await http.patch(url, headers: headers, body: body);
    if(response.statusCode == 200){
      return EditMemberResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  // =========================== EVENT ================================

  Future<AddEventResponseModel> addEvent(AddEventRequestModel addEventRequestModel, String token) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    String url = Config.url + Config.addEvent;
    final body = jsonEncode(addEventRequestModel);
    final response = await http.post(url,headers: headers, body: body);
    if(response.statusCode == 200){
      return AddEventResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  } 

    Future<Event> listEvent(String token, DateTime time) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    String url = Config.url + Config.getEvent + time.toString();
    print(url);
    final response = await http.get(url, headers: headers);
    print(response.body);
    if(response.statusCode == 200 || response.statusCode == 401){
      return Event.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

}