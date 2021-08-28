import 'package:ctxhadminpage/Widget/drawer.dart';
import 'package:flutter/material.dart';

class AdminActivityPage extends StatefulWidget {

  @override
  _AdminActivityPageState createState() => _AdminActivityPageState();
}

class _AdminActivityPageState extends State<AdminActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
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
      body: Center(
        child: Text('This is Activity Page'),
      ),
    );
  }
}