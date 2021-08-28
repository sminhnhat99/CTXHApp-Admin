import 'package:cool_alert/cool_alert.dart';
import 'package:ctxhadminpage/Page/_addMemberPage.dart';
import 'package:ctxhadminpage/Page/_memberDetails.dart';
import 'package:ctxhadminpage/Page/_searchPage.dart';
import 'package:ctxhadminpage/Widget/drawer.dart';
import 'package:ctxhadminpage/api_Service/apiService.dart';
import 'package:ctxhadminpage/constant.dart';
import 'package:ctxhadminpage/model/_readMemberModel.dart';
import 'package:ctxhadminpage/share_token.dart';
import 'package:flutter/material.dart';
import 'package:unicorndial/unicorndial.dart';

class AdminMemberPage extends StatefulWidget {
  final String accountDetail;
  AdminMemberPage({this.accountDetail});
  @override
  _AdminMemberPageState createState() => _AdminMemberPageState(accountDetail : accountDetail);
}

class _AdminMemberPageState extends State<AdminMemberPage> {
  String accountDetail;
  _AdminMemberPageState({this.accountDetail});
  final _searchController = TextEditingController();
  APIService apiService;
  String sharetoken;
  
  int pageIndex = 1;
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
    return Container(
      child: _fetchMemberData(),
    );
  }

  Widget _fetchMemberData() {
    return FutureBuilder<Member>(
      future: apiService.listMember(sharetoken, pageIndex),
      builder: (BuildContext context, AsyncSnapshot<Member> snapshot){
        if(snapshot.hasData){
          return _showListMember(snapshot.data);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _showListMember(Member member) {
   return WillPopScope(
     onWillPop: () async => true,
     child: Scaffold(
       drawer: DrawerWidget(accountDetail: this.widget.accountDetail,),
       appBar: AppBar(
          elevation: 0.5,
          backgroundColor: Colors.blueAccent,
          title: Text('Member Management'),
          centerTitle: true,
        ),
       body: Padding(
         padding: const EdgeInsets.only(top: 16.0),
         child: SingleChildScrollView(
           child: Column(
             children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Visibility(
                     child: ElevatedButton(
                       onPressed: (){
                         setState(() {
                           pageIndex -= 1;
                           _fetchMemberData();
                         });
                       },
                       child: Row(
                         children: [
                           Icon(Icons.arrow_back, color: Colors.white,),
                           SizedBox(width: 8.0,),
                           Text('Previous Page'),
                         ],
                       ),
                     ),
                     visible: pageIndex == 1 ? false : true,
                   ),
                   SizedBox(width: 30.0,),
                   Visibility(
                     child: ElevatedButton(
                       onPressed: (){
                          setState(() {
                           pageIndex += 1;
                           _fetchMemberData();
                         });
                       },
                       child: Row(
                         children: [
                           Text('Next Page'),
                           SizedBox(width: 8.0,),
                           Icon(Icons.arrow_forward, color: Colors.white,)
                         ],
                       ),
                     ),
                     visible: member.data.length > 9 ? false : true,
                   ),
                 ],
               ),
               SizedBox(height: 40.0,),
               GridView.builder(
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
                                                apiService.deleteMember(sharetoken, memberData.sId)
                                                  .then((value) => {
                                                    if(value.success == 1) {
                                                      setState(() {})
                                                    } else {
                                                      CoolAlert.show(
                                                        width: 300.0,
                                                        context: context,
                                                        type: CoolAlertType.error,
                                                        text: 'You are not authorized to do this',
                                                        onCancelBtnTap: (){
                                                        Navigator.of(context).pop();
                                                        },
                                                        cancelBtnText: 'OK',
                                                      )
                                                    }
                                                  });
                                                  Navigator.of(context).pop();
                                              },
                                              child: Text('Yes', style: TextStyle(color: Colors.blueAccent, fontSize: 15.0, fontWeight: FontWeight.bold),),
                                            ),
                                            new TextButton(
                                              onPressed: (){
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('No', style: TextStyle(color: Colors.redAccent, fontSize: 15.0, fontWeight: FontWeight.bold),),
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
             ],
           ),
         ),
       ),
       floatingActionButton: UnicornDialer(
         backgroundColor: Color.fromRGBO(255, 255, 255, 0.3),
         parentButtonBackground: Colors.blueAccent,
         orientation: UnicornOrientation.VERTICAL,
         parentButton: Icon(Icons.list),
         childButtons: [
           UnicornButton(
          hasLabel: true,
          labelText: 'Add',
          currentButton: FloatingActionButton(
            heroTag: 'add',
            backgroundColor: Colors.greenAccent,
            mini: true,
            child: Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminAddMember()));
            },
          ),
        ),
        UnicornButton(
          hasLabel: true,
          labelText: 'Search',
          currentButton: FloatingActionButton(
            heroTag: 'search',
            backgroundColor: Colors.redAccent,
            mini: true,
            child: Icon(Icons.search),
            onPressed: (){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Tìm kiếm'),
                    content: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Form(
                            child: TextFormField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Nội dung tìm kiếm',
                                enabledBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(15.0),
                                borderSide: BorderSide(color: Colors.lightBlueAccent),
                                ),
                                prefixIcon: Icon(Icons.search, color: Theme.of(context).accentColor,),
                                hintStyle: TextStyle(color: Theme.of(context).accentColor)
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0,),
                          Text('Chọn cách tìm kiếm: ', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                          SizedBox(height: 10.0,),
                          Row(
                            children: [
                              TextButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AdminSearchPage(memberName: _searchController.text, chooseType: 1,)));
                                },
                                child: Text('Họ và tên'),
                              ),
                              SizedBox(width: 20.0,),
                              TextButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AdminSearchPage(memberName: _searchController.text, chooseType: 2,)));
                                },
                                child: Text('Chức vụ trong Đội'),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0,),
                          Row(
                            children: [
                              TextButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AdminSearchPage(memberName: _searchController.text, chooseType: 3,)));
                                },
                                child: Text('Khóa Đội viên'),
                              ),
                              SizedBox(width: 20.0,),
                              TextButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AdminSearchPage(memberName: _searchController.text, chooseType: 4,)));
                                },
                                child: Text('Chức vụ trong ban'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }
              );
            },
          ),
        )
         ],
       ),
      ),
   );
  }
}