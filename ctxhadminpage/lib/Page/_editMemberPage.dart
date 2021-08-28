import 'package:cool_alert/cool_alert.dart';
import 'package:ctxhadminpage/Page/_memberPage.dart';
import 'package:ctxhadminpage/ProgessHUD.dart';
import 'package:ctxhadminpage/Widget/drawer.dart';
import 'package:ctxhadminpage/api_Service/apiService.dart';
import 'package:ctxhadminpage/model/_editMemberModel.dart';
import 'package:ctxhadminpage/share_token.dart';
import 'package:flutter/material.dart';
import 'package:ctxhadminpage/model/_readMemberModel.dart';

class AdminEditMemberPage extends StatefulWidget {
  final Data memberEdit;
  AdminEditMemberPage({this.memberEdit});

  @override
  _AdminEditMemberPageState createState() => _AdminEditMemberPageState(memberEdit: memberEdit);
}

class _AdminEditMemberPageState extends State<AdminEditMemberPage> {
  Data memberEdit;
  _AdminEditMemberPageState({this.memberEdit});
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _positionController = TextEditingController();
  final _KDVController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _roleController = TextEditingController();
  final _memberImageController = TextEditingController();
  APIService apiService;
  String sharetoken;
  EditMemberRequestModel editMemberRequestModel;
  bool isApiCallProgress = false;

  @override
  void initState(){
    super.initState();
    apiService = new APIService();
    editMemberRequestModel = new EditMemberRequestModel();
    MySharedPreferences.instance
      .getStringValue('token')
      .then((value) => setState((){
        sharetoken = value;
      }));
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiEditMember(context),
      inAsyncCall: isApiCallProgress,
      opacity: 0.3,
    );
  }

  Widget _uiEditMember(BuildContext context) {
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
                  apiService.editMember(editMemberRequestModel, sharetoken, this.widget.memberEdit.sId)
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
                          onSaved: (input) => input.length == 0
                          ? editMemberRequestModel.name = this.widget.memberEdit.name
                          : editMemberRequestModel.name = input,
                          validator: (value) {
                            if(value.length != 0 && value.length < 6) {
                              return 'Name cannot empty!!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: this.widget.memberEdit.name,
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
                          onSaved: (input) => input.length == 0
                          ? editMemberRequestModel.role = this.widget.memberEdit.role
                          : editMemberRequestModel.role = input,
                          decoration: InputDecoration(
                            hintText: this.widget.memberEdit.role,
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
                          onSaved: (input) => input.length == 0
                          ? editMemberRequestModel.KDV = this.widget.memberEdit.kDV
                          : editMemberRequestModel.KDV = int.parse(input),
                          validator: (value) {
                            if(value.length != 0 && value.length < 6) {
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
                          onSaved: (input) => input.length == 0
                          ? editMemberRequestModel.position = this.widget.memberEdit.position
                          : editMemberRequestModel.position = input,
                          validator: (value) {
                            if(value.length != 0 && value.length < 6) {
                              return 'Position cannot empty!!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: this.widget.memberEdit.position,
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
                        onSaved: (input) => input.length == 0
                        ? editMemberRequestModel.memberImage = this.widget.memberEdit.memberImage
                        : editMemberRequestModel.memberImage = input,
                          decoration: InputDecoration(
                            hintText: this.widget.memberEdit.memberImage,
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
                  maxLines: 8,
                  onSaved: (input) => input.length == 0
                  ? editMemberRequestModel.description = this.widget.memberEdit.description
                  : editMemberRequestModel.description = input,
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'Description cannot empty!!';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: this.widget.memberEdit.description,
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