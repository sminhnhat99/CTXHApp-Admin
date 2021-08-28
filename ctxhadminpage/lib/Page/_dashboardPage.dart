import 'package:ctxhadminpage/Widget/drawer.dart';
import 'package:ctxhadminpage/model/_userModel.dart';
import 'package:flutter/material.dart';

class AdminDashboardPage extends StatefulWidget {
  final String accountDetail;
  AdminDashboardPage({this.accountDetail});
  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState(accountDetails: accountDetail);
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  String accountDetails;
  _AdminDashboardPageState({this.accountDetails});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(accountDetail: this.widget.accountDetail,),
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.blueAccent,
        title: Text('Dashboard'),
        actions: [
          IconButton(icon: Icon(Icons.mail), onPressed: (){}),
          IconButton(icon: Icon(Icons.notifications), onPressed: (){}),
          CircleAvatar(child: Icon(Icons.person),)
        ],
      ),
    );
  }
}