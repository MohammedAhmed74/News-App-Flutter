import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class Business_screen extends StatelessWidget {
  const Business_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {
        print(state.toString());
      },
      builder: (context, state) => ConditionalBuilder(
          condition: NewsCubit.get(context).business.length != 0,
          builder: (context) {
            print('business : ');
            NewsCubit.get(context).business.forEach((element) {
              print(element['urlToImage']);
            });
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => NewsItemWidget(
                      article: NewsCubit.get(context).business,
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
                  itemCount: NewsCubit.get(context).business.length),
            );
          },
          fallback: (context) {
            print('fallback............');
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
