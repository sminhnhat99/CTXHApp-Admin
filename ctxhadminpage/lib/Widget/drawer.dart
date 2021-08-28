import 'package:ctxhadminpage/Page/_dashboardPage.dart';
import 'package:ctxhadminpage/Page/_loginPage.dart';
import 'package:flutter/material.dart';
import 'package:ctxhadminpage/Page/_activityPage.dart';
import 'package:ctxhadminpage/Page/_eventCalendarPage.dart';
import 'package:ctxhadminpage/Page/_memberPage.dart';
import 'package:ctxhadminpage/Page/_orderPage.dart';

class DrawerWidget extends StatefulWidget {
  final String accountDetail;
  DrawerWidget({this.accountDetail});
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState(accountDetail: accountDetail);
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String accountDetail;
  _DrawerWidgetState({this.accountDetail});
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountEmail: Text(this.widget.accountDetail),
              accountName: Text(this.widget.accountDetail),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  child: Icon(Icons.person),
                ),
              ),
            ),
            InkWell(
              onTap:(){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminDashboardPage(accountDetail: this.widget.accountDetail,)));
              },
              child: ListTile(
                title: Text('Dashboard'),
                leading: Icon(Icons.dashboard,
                color: Colors.blueAccent,),
              ),
            ),
            InkWell(
              onTap:(){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminMemberPage(accountDetail: this.widget.accountDetail,)));
              },
              child: ListTile(
                title: Text('Member Management'),
                leading: Icon(Icons.group, 
                color: Colors.blueAccent,),
              ),
            ),
            InkWell(
              onTap:(){
                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminActivityPage()));
              },
              child: ListTile(
                title: Text('Activity Management'),
                leading: Icon(Icons.schedule, 
                color: Colors.blueAccent,),
              ),
            ),
            InkWell(
              onTap:(){
                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminOrderPage()));
              },
              child: ListTile(
                title: Text('Order Management'),
                leading: Icon(Icons.list, 
                color: Colors.blueAccent,),
              ),
            ),
            InkWell(
              onTap:(){
                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminEventCalendarPage()));
              },
              child: ListTile(
                title: Text('Event Management'),
                leading: Icon(Icons.calendar_today, color: Colors.blueAccent,),
              ),
            ),
            Divider(),
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminLoginPage()));
              },
              child: ListTile(
                title: Text('Log Out'),
                leading: Icon(Icons.logout, color: Colors.blueAccent,),
              ),
            )
          ],
        ),
      );
  }
}