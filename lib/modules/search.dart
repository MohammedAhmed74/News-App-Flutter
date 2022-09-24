import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class Search_Screen extends StatefulWidget {
  @override
  _Search_ScreenState createState() => _Search_ScreenState();
}

class _Search_ScreenState extends State<Search_Screen> {
  TextEditingController searchCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    NewsCubit cubit = NewsCubit.get(context);
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (cotext, state) {},
      builder: (cotext, state) {
        double height = MediaQuery.of(context).size.height;
        return Scaffold(
          appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: cubit.textFormColor,
                  ))),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
                child: !cubit.beforeSearch
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: defaultFormField(
                              txtcon1: searchCtrl,
                              lable: 'Search',
                              autoFocus: true,
                              color: cubit.textFormColor,
                              pre: Icon(
                                Icons.search,
                                color: cubit.textFormColor,
                              ),
                              onChange: (text) {
                                cubit.getSearchData(text);
                                if (text == '') {
                                  cubit.search = [];
                                  cubit.emptySearchList();
                                }
                              },
                              onFieldSubmitted: (s) {
                                if (s == '') {
                                  cubit.beforeSearch = true;
                                } else
                                  print(s);

                                cubit.emptySearchList();
                                return '$s';
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: height - 200,
                            child: ListView.separated(
                                // shrinkWrap: true,
                                // physics: NeverScrollableScrollPhysics(),
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) => NewsItemWidget(
                                    article: NewsCubit.get(context).search,
                                    index: index,
                                    context: context),
                                separatorBuilder: (context, index) {
                                  return Container(
                                    height: 35,
                                    child: Center(
                                      child: Container(
                                        height: 0.5,
                                        color: Colors.grey[400],
                                        width: 320,
                                      ),
                                    ),
                                  );
                                },
                                itemCount:
                                    NewsCubit.get(context).search.length),
                          ),
                        ],
                      )
                    : Container(
                        height: height / 3,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                'NewsApp',
                                style: TextStyle(
                                    color: cubit.textFormColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 27),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: defaultFormField(
                                txtcon1: searchCtrl,
                                onTap: () {
                                  cubit.search = [];
                                  cubit.beforeSearch = false;
                                  cubit.startSearching();
                                },
                                lable: 'Search',
                                color: cubit.textFormColor,
                                pre: Icon(
                                  Icons.search,
                                  color: cubit.textFormColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
          ),
        );
      },
    );
  }
}
