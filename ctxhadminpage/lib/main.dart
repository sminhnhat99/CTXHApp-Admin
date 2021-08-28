import 'package:ctxhadminpage/Page/_addMemberPage.dart';
import 'package:ctxhadminpage/Page/_loginPage.dart';
import 'package:ctxhadminpage/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CTXH Admin Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.varelaRoundTextTheme(Theme.of(context).textTheme.apply(bodyColor: Colors.white)),
        // textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme.apply(bodyColor: Colors.white)),
        canvasColor: secondaryColor
      ),
      home: AdminLoginPage(),
    );
  }
}