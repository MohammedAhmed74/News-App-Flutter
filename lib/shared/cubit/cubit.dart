import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business.dart';
import 'package:news_app/modules/science.dart';
import 'package:news_app/modules/settinges.dart';
import 'package:news_app/modules/sports.dart';
import 'package:news_app/shared/cubit/states.dart';

import 'package:news_app/shared/network/cacheHelper.dart';
import 'package:news_app/shared/network/dioHelper.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(InitialNewsState());
  static NewsCubit get(context) => BlocProvider.of(context);

  // textDirection == TextDirection.ltr
  //     ? textDirection = TextDirection.rtl
  //     : textDirection = TextDirection.ltr;
  bool lightMode = true;
  TextDirection textDirection = TextDirection.rtl;
  changeThemeMode({required bool? lightMode}) {
    if (lightMode == null) {
      this.lightMode == true ? this.lightMode = false : this.lightMode = true;
      cacheHelper.setBool(key: 'lightMode', value: this.lightMode);
    } else {
      this.lightMode = !cacheHelper.getBool(key: 'lightMode')!;
      cacheHelper.setBool(key: 'lightMode', value: this.lightMode);
    }
    setFormFeildColor();
    emit(ChangeThemeState());
  }

  List<Widget> Screens = [
    Business_screen(),
    Sports_screen(),
    Science_screen(),
  ];

  List<BottomNavigationBarItem> BottomNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];

  int currentIndex = 0;

  BottomNavChange(int index) {
    currentIndex = index;
    if (currentIndex == 1) {
      emit(SportsLoadingState());
      getSportsData('v2/top-headlines', {
        'country': 'eg',
        'category': 'sports',
        'apiKey': 'a5e8541c5f944dde8547b8d59c3ff79a',
      }).then((value) {
        emit(GetSportsDataState());
      }).catchError((error) {
        print('getSportsDataError : $error');
      });
    } else if (currentIndex == 2) {
      emit(ScienceLoadingState());
      getScienceData('v2/top-headlines', {
        'country': 'eg',
        'category': 'science',
        'apiKey': 'a5e8541c5f944dde8547b8d59c3ff79a',
      }).then((value) {
        emit(GetScienceDataState());
      }).catchError((error) {
        print('getScienceDataError : $error');
      });
    }
    emit(BottomNavState());
  }

  dynamic allData;
  Future getData(String url, Map<String, dynamic> query) async {
    allData = await dioHelper.dio.get(url, queryParameters: query);
    return allData;
  }

  List<dynamic> business = [];
  Future getBusinessData(String url, Map<String, dynamic> query) async {
    emit(BusinessLoadingState());
    getData(url, query).then((value) {
      business = value.data['articles'];
      print('business initialized .....................');
      emit(GetDataState());
    }).catchError((error) {
      print('EEE: $error');
      emit(CatchBusinessErrorState(error.toString()));
      print('catchBusinessErrorState()............................');
    });
  }

  List<dynamic> sports = [];
  Future getSportsData(String url, Map<String, dynamic> query) async {
    emit(SportsLoadingState());
    getData(url, query).then((value) {
      sports = value.data['articles'];
      print('sports initialized .....................');
      print(sports.length);
      emit(GetDataState());
    }).catchError((error) {
      print('EEE: $error');
      emit(CatchSportsErrorState(error.toString()));
      print('catchSportsErrorState()............................');
      print(error);
    });
  }

  List<dynamic> science = [];
  Future getScienceData(String url, Map<String, dynamic> query) async {
    emit(ScienceLoadingState());
    getData(url, query).then((value) {
      science = value.data['articles'];
      print('science initialized .....................');
      emit(GetDataState());
    }).catchError((error) {
      print('EEE: $error');
      emit(CatchScienceErrorState(error.toString()));
      print('catchScienceErrorState()............................');
    });
  }

  //https://newsapi.org/v2/everything?q=tesla&apiKey=a5e8541c5f944dde8547b8d59c3ff79a

  List<dynamic> search = [];
  Future getSearchData(String target) async {
    emit(ScienceLoadingState());
    if (target == '') {
      search = [];
      print("OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
    } else {
      Map<String, dynamic> searchQuery = {
        'q': target,
        'apiKey': 'a5e8541c5f944dde8547b8d59c3ff79a'
      };
      getData('v2/everything', searchQuery).then((value) {
        search = value.data['articles'];
        print('search .....................');
        emit(GetDataState());
        emit(ChangeSearchState());
      }).catchError((error) {
        print('EEE: $error');
        emit(CatchScienceErrorState(error.toString()));
        print('catchScienceErrorState()............................');
      });
    }
  }

  void emptySearchList() {
    emit(ChangeSearchState());
  }

  void startSearching() {
    emit(ChangeSearchState());
  }

  Color textFormColor = Colors.black;
  void setFormFeildColor() {
    textFormColor = cacheHelper.getBool(key: 'lightMode') == true
        ? Colors.black
        : Colors.white;
    emit(ChangeSearchState());
  }

  bool beforeSearch = true;
}
