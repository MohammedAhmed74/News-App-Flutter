import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layouts/news_layout.dart';
import 'package:news_app/modules/business.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/cacheHelper.dart';
import 'package:news_app/shared/network/dioHelper.dart';
import 'package:news_app/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  dioHelper.init();
  await cacheHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()
        ..getBusinessData('v2/top-headlines', {
          'country': 'eg',
          'category': 'business',
          'apiKey': 'a5e8541c5f944dde8547b8d59c3ff79a',
        }).then((value) {
          print(value);
        }).catchError((error) {
          print('E111111 : $error');
        })
        ..setFormFeildColor(),
      child: BlocConsumer<NewsCubit, NewsState>(
          listener: (context, state) {},
          builder: (context, state) {
            NewsCubit cubit = NewsCubit.get(context);
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: cacheHelper.getBool(key: 'lightMode') == false
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: Directionality(
                  textDirection: cubit.textDirection, child: NewsLayout()),
            );
          }),
    );
  }
}
