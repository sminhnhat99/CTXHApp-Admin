import 'package:ctxhadminpage/Page/_editMemberPage.dart';
import 'package:ctxhadminpage/api_Service/apiService.dart';
import 'package:ctxhadminpage/constant.dart';
import 'package:ctxhadminpage/share_token.dart';
import 'package:flutter/material.dart';
import 'package:ctxhadminpage/model/_readMemberModel.dart';

class AdminMemberDetails extends StatefulWidget {
  final Data memberDetail;
  AdminMemberDetails({this.memberDetail});
  @override
  _AdminMemberDetailsState createState() => _AdminMemberDetailsState(memberDetail: memberDetail);
}

class _AdminMemberDetailsState extends State<AdminMemberDetails> {
  Data memberDetail;
  _AdminMemberDetailsState({this.memberDetail});
  APIService apiService;
  String sharetoken;
  String memberId;
  @override
  void initState(){
    super.initState();
    apiService = new APIService();
    MySharedPreferences.instance
      .getStringValue('token')
      .then((value) => setState((){
        sharetoken = value;
      }));
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.blueAccent,
        title: Text('Member Details', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminEditMemberPage(memberEdit: memberDetail,)));
            },
            icon: Icon(Icons.edit, color: Colors.white,),)
        ]
      ),
      body: Center(
        child: Container(
          height: 500.0,
          width: 800.0,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blueAccent,
              width: 1.0
            ),
            borderRadius: BorderRadius.circular(7.0)
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 10.0),
                  width: 300.0,
                  height: 300.0,
                  decoration: BoxDecoration(
                    image: new DecorationImage(
                      image: NetworkImage('https://drive.google.com/uc?export=view&id=' + this.widget.memberDetail.memberImage),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                flex: 2,
              ),
              VerticalDivider(color:Colors.blueAccent, thickness: 2.0),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(this.widget.memberDetail.name, style: TextStyle(color: Colors.blueAccent,fontSize: 25.0, fontWeight: FontWeight.bold),),
                      SizedBox(height: 20.0),
                      Text('Chức vụ: ' + this.widget.memberDetail.position, style: TextStyle(fontSize: 20.0,),),
                      SizedBox(height: 20.0),
                      Text('Khóa Đội viên: ' + this.widget.memberDetail.kDV.toString(),style: TextStyle(fontSize: 20.0,),),
                      SizedBox(height: 20.0),
                      Text(this.widget.memberDetail.role == null ? 'Đội viên' : this.widget.memberDetail.role,style: TextStyle(fontSize: 20.0,),),
                      SizedBox(height: 20.0),
                      Text('Mô tả', style: TextStyle(fontSize: 25, color: Colors.blueAccent, fontWeight: FontWeight.bold),),
                      SizedBox(height: 20.0),
                      Text(this.widget.memberDetail.description, style: TextStyle(fontSize: 20.0))
                    ],
                  ),
                ),
                flex: 3,
              )
            ],
          ),
        ),
      ),
    );
  }
}