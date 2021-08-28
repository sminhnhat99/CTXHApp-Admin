import 'package:cool_alert/cool_alert.dart';
import 'package:ctxhadminpage/Page/_dashboardPage.dart';
import 'package:ctxhadminpage/ProgessHUD.dart';
import 'package:ctxhadminpage/api_Service/apiService.dart';
import 'package:ctxhadminpage/model/_loginModel.dart';
import 'package:ctxhadminpage/share_token.dart';
import 'package:flutter/material.dart';

class AdminLoginPage extends StatefulWidget {

  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  bool isApiCallProgress = false;
  bool hidePassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  LoginRequestModel loginRequestModel;
  
  @override
  void initState(){
    super.initState();
    loginRequestModel = new LoginRequestModel();
    MySharedPreferences.instance
      .setStringValue('token', '');
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _loginUI(context),
      inAsyncCall: isApiCallProgress,
      opacity: 0.3,
    );
  }

  Widget _loginUI(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF212332),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Container(
                width: 500.0,
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                margin: EdgeInsets.symmetric(vertical: 85.0, horizontal: 450.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Color(0xFF2A2D3E),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                          offset: Offset(0, 10.0),
                          blurRadius: 20.0)
                    ]),
                child: Form(
                  key: globalFormKey,
                  child: Column(
                    children: [
                      SizedBox(height: 25.0),
                      Text('CTXHSPKT',
                          style: TextStyle(color: Colors.blueAccent, fontSize: 60.0, fontWeight: FontWeight.bold),),
                      Text('Admin Login', style: TextStyle(fontSize: 40.0, color: Colors.white), textAlign: TextAlign.center,),
                      SizedBox(height: 20.0),
                      new TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (input) => 
                          loginRequestModel.email = input,
                        validator: (input) => !input.contains("@")
                            ? "Email ID should be valid"
                            : null,
                        decoration: new InputDecoration(
                            hintText: "Email Address",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF2697FF)
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Color(0xFF2697FF),
                            )),
                      ),
                      SizedBox(height: 20.0),
                      new TextFormField(
                        controller: _passwordController,
                        obscureText: hidePassword,
                        keyboardType: TextInputType.text,
                        onSaved: (input) =>
                          loginRequestModel.password = input,
                        validator: (input) => input.length < 3
                            ? "Password should be more than 3 characters"
                            : null,
                        decoration: new InputDecoration(
                            hintText: "Password",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF2697FF)
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color(0xFF2697FF),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.4),
                              icon: Icon(hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            )),
                      ),
                      SizedBox(height: 30.0,),
                      SizedBox(
                        width: 180.0,
                        height: 60.0,
                        child: ElevatedButton(
                          onPressed: (){
                            if(validateAndSave()) {
                              setState(() {
                                isApiCallProgress = true;
                              });

                              APIService apiService = new APIService();
                              print(loginRequestModel.email);
                              print(loginRequestModel.password);
                              apiService
                                .login(loginRequestModel)
                                .then((value) {
                                  setState(() {
                                    isApiCallProgress = false;
                                    print(value.success);
                                    print(value.message);
                                  });
                                  if(value.success == 1) {
                                     MySharedPreferences.instance
                                        .setStringValue('token', value.token);
                                    //_emailController.clear();
                                    _passwordController.clear();
                                    return CoolAlert.show(
                                      width: 300.0,
                                      context: context,
                                      type: CoolAlertType.success,
                                      text: 'Login Successfully',
                                      onConfirmBtnTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminDashboardPage(accountDetail: _emailController.text,)));
                                      },
                                    );
                                  }
                                  else {
                                    return CoolAlert.show(
                                      width: 300.0,
                                      context: context,
                                      type: CoolAlertType.error,
                                      text: 'Your email or password is incorrect!',
                                      onCancelBtnTap: (){
                                        Navigator.of(context).pop();
                                        },
                                        cancelBtnText: 'OK',
                                    );
                                  }
                                }
                                );
                            }
                          }, 
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 22.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],)
          ],
        ),
      ),
    );
  }
  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}