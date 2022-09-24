import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData? lightTheme = ThemeData(
    textTheme: TextTheme(
        bodyText1: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16)),
    primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        actionsIconTheme: IconThemeData(
          color: Colors.black,
          size: 30,
        ),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white10,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.deepOrange),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.deepOrange,
    ));

ThemeData? darkTheme = ThemeData(
    textTheme: TextTheme(
        bodyText1: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
    primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor: HexColor('#181818'),
    appBarTheme: AppBarTheme(
        actionsIconTheme: IconThemeData(
          color: Colors.white,
          size: 30,
        ),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('#181818'),
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: Color(0x474747),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: HexColor('#181818'),
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.deepOrange),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.deepOrange,
    ));
