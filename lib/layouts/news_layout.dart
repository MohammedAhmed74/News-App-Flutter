import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/cacheHelper.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(listener: (context, state) {
      print(state.toString());
    }, builder: (context, state) {
      NewsCubit cubit = NewsCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('NewsApp'),
          ),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 15),
              child: IconButton(
                icon: Icon(Icons.search_sharp),
                onPressed: () {
                  cubit.search = [];
                  cubit.beforeSearch = true;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => Search_Screen()));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 15),
              child: IconButton(
                icon: Icon(Icons.brightness_4_outlined),
                onPressed: () {
                  print(cacheHelper.getBool(key: 'lightMode'));
                  cubit.changeThemeMode(
                      lightMode: cacheHelper.getBool(key: 'lightMode'));
                }, 
              ),
            ),
          ],
        ),
        body: cubit.Screens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 25,
          iconSize: 30,
          items: cubit.BottomNavItems,
          currentIndex: cubit.currentIndex,
          onTap: (index) {
            cubit.BottomNavChange(index);
          },
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     cubit.getData('v2/top-headlines', {
        //       'counrty': 'eg',
        //       'category': 'business',
        //       'apiKey': 'a5e8541c5f944dde8547b8d59c3ff79a',
        //     }).then((value) {
        //       print(value);
        //     }).catchError((error) {
        //       print('error : $error');
        //     });
        //   },
        //   child: Icon(Icons.add),
        // ),
      );
    });
  }
}
