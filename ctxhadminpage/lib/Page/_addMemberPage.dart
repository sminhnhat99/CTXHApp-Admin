import 'package:cool_alert/cool_alert.dart';
import 'package:ctxhadminpage/Page/_memberPage.dart';
import 'package:ctxhadminpage/ProgessHUD.dart';
import 'package:ctxhadminpage/Widget/drawer.dart';
import 'package:ctxhadminpage/api_Service/apiService.dart';
import 'package:ctxhadminpage/model/_addMemberModel.dart';
import 'package:ctxhadminpage/share_token.dart';
import 'package:flutter/material.dart';


class AdminAddMember extends StatefulWidget {
  @override
  _AdminAddMemberState createState() => _AdminAddMemberState();
}

class _AdminAddMemberState extends State<AdminAddMember> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _positionController = TextEditingController();
  final _KDVController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _roleController = TextEditingController();
  final _memberImageController = TextEditingController();
  APIService apiService;
  String sharetoken;
  AddMemberRequestModel addMemberRequestModel;
  bool isApiCallProgress = false;
  @override
  void initState(){
    super.initState();
    apiService = new APIService();
    addMemberRequestModel = new AddMemberRequestModel();
    MySharedPreferences.instance
      .getStringValue('token')
      .then((value) => setState(() {
        sharetoken = value;
      }));
  }
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiAddMember(context),
      inAsyncCall: isApiCallProgress,
      opacity: 0.3,
    );
  }

  Widget _uiAddMember(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.blueAccent,
        title: Text('Add New Member'),
        centerTitle: true,
        actions: [
          ButtonTheme(
            minWidth: 200.0,
            height: 50.0,
            child: ElevatedButton(
              
// =================== Save Infomation =====================

              onPressed: (){
                 if(validateAndSave()){
                  setState((){
                    isApiCallProgress = true;
                  });

                  //Call API
                  APIService apiService = new APIService();
                  addMemberRequestModel.name = _nameController.value.text;
                  addMemberRequestModel.position = _positionController.value.text;
                  addMemberRequestModel.KDV = int.parse(_KDVController.text);
                  addMemberRequestModel.description = _descriptionController.value.text;
                  addMemberRequestModel.role = _roleController.value.text;
                  addMemberRequestModel.memberImage = _memberImageController.value.text;
                  apiService.addMember(addMemberRequestModel, sharetoken)
                    .then((value) {
                      setState((){
                        isApiCallProgress = false;
                      });
                      if(value != null){
                        setState((){
                          isApiCallProgress = false;
                          print(value.message);
                          print(value.success);
                        });
                        if(value.success == 1){
                          return CoolAlert.show(
                            context: context,
                            type: CoolAlertType.success,
                            text: 'Add Successful!',
                            onConfirmBtnTap: (){
                              Navigator.push( context, MaterialPageRoute( builder: (context) => AdminMemberPage()), ).then((value) => setState(() {}));
                            }
                          );
                        } else {
                          return CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            text: 'Add Fail!'
                          );
                        }
                      }
                    });
                }
              },
              child: Row(
                children: [
                  Text('Save', style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(width: 10.0,),
                  Icon(Icons.save)
                ],
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 20.0),
          width: 800.0,
          height: 630.0,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _nameController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if(value == null || value.isEmpty) {
                              return 'Name cannot empty!!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Name',
                            focusedBorder: new UnderlineInputBorder(
                              borderSide: new BorderSide(
                                color: Colors.blue
                              )
                            ),
                            hintStyle: TextStyle(color: Colors.blue)
                          ),
                      ),
                      flex: 3,
                    ),
                    SizedBox(width: 10.0,),
                    Expanded(
                      child: TextFormField(
                        controller: _roleController,
                          keyboardType: TextInputType.text,
                          onSaved: (input) => 
                            addMemberRequestModel.role = input,
                          decoration: InputDecoration(
                            hintText: 'Role',
                            focusedBorder: new UnderlineInputBorder(
                              borderSide: new BorderSide(
                                color: Colors.blue
                              )
                            ),
                            hintStyle: TextStyle(color: Colors.blue)
                          ),
                      ),
                      flex: 3,
                    ),
                  ],
                ),
                SizedBox(height: 40.0,),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                         controller: _KDVController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if(value == null || value.isEmpty) {
                              return 'Khoa Doi Vien cannot empty!!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Khoa Doi Vien',
                            focusedBorder: new UnderlineInputBorder(
                              borderSide: new BorderSide(
                                color: Colors.blue
                              )
                            ),
                            hintStyle: TextStyle(color: Colors.blue)
                          ),
                      ),
                      flex: 1,
                    ),
                    SizedBox(width: 10.0,),
                    Expanded(
                      child: TextFormField(
                        controller: _positionController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if(value == null || value.isEmpty) {
                              return 'Position cannot empty!!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Position',
                            focusedBorder: new UnderlineInputBorder(
                              borderSide: new BorderSide(
                                color: Colors.blue
                              )
                            ),
                            hintStyle: TextStyle(color: Colors.blue)
                          ),
                      ),
                      flex: 1,
                    ),
                    SizedBox(width: 10.0,),
                    Expanded(
                      child: TextFormField(
                        controller: _memberImageController,
                          decoration: InputDecoration(
                            hintText: 'Image: Put your Google Drive image code here',
                            focusedBorder: new UnderlineInputBorder(
                              borderSide: new BorderSide(
                                color: Colors.blue
                              )
                            ),
                            hintStyle: TextStyle(color: Colors.blue)
                          ),
                      ),
                      flex: 2,
                    )
                  ],
                ),
                SizedBox(height: 40.0,),
                TextFormField(
                  controller: _descriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'Description cannot empty!!';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Description',
                    focusedBorder: new UnderlineInputBorder(
                      borderSide: new BorderSide(
                        color: Colors.blue
                      )
                    ),
                    hintStyle: TextStyle(color: Colors.blue)
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  bool validateAndSave(){
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }
}

