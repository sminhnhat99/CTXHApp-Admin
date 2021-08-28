import 'package:ctxhadminpage/Page/_memberDetails.dart';
import 'package:ctxhadminpage/api_Service/apiService.dart';
import 'package:ctxhadminpage/constant.dart';
import 'package:ctxhadminpage/model/_readMemberModel.dart';
import 'package:ctxhadminpage/share_token.dart';
import 'package:flutter/material.dart';

class AdminSearchPage extends StatefulWidget {
  final String memberName;
  final int chooseType;
  AdminSearchPage({this.memberName, this.chooseType});
  @override
  _AdminSearchPageState createState() => _AdminSearchPageState(memberName: memberName, chooseType: chooseType);
}

class _AdminSearchPageState extends State<AdminSearchPage> {
  String memberName;
  int chooseType;
  _AdminSearchPageState({this.memberName, this.chooseType});
  APIService apiService;
  String sharetoken;
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
  Widget build(BuildContext context){
    return Container(
      child: _fetchData(),
    );
  }
  Widget _fetchData() {
  return FutureBuilder<Member>(
      future: apiService.searchMember(sharetoken, this.widget.memberName, this.widget.chooseType),
      builder: (BuildContext context, AsyncSnapshot<Member> snapshot){
        if(snapshot.hasData){
          return _showSearchName(snapshot.data);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _showSearchName(Member member) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.blueAccent,
        title: Text('Kết quả tìm kiếm', style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
       child: GridView.builder(
          shrinkWrap: true,
          itemCount: member.data.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 15/9 ),
          itemBuilder: (context, index){
            var memberData = member.data[index];
            return InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminMemberDetails(memberDetail: memberData,)));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    color: secondaryColor,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.blueAccent, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: 150.0,
                            height: 120.0,
                            decoration: BoxDecoration(
                               image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: new NetworkImage((
                               'https://drive.google.com/uc?export=view&id=' + memberData.memberImage.toString()
                            ),
                          )),
                            ),
                          ),
                        ),
                        SizedBox(width: 1.0,),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: Text(
                                  memberData.name.toString(),
                                  style: TextStyle(fontSize: 17.0, color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  title: Text('Delete this member ?'),
                                  content: Text('This action will delete this member permanently'),
                                  actions: [
                                    new TextButton(
                                      onPressed: (){
        
                                      },
                                      child: Text('No', style: TextStyle(color: Colors.redAccent),),
                                    )
                                  ],
                                );
                              }
                            );
                          },
                          child: Text('Delete', style: TextStyle(fontSize: 15.0,),),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.redAccent,
                          ),
                        ),
                        
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
     )
    );
  }
}