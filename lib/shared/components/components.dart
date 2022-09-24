import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/webView.dart';
import 'package:news_app/shared/cubit/cubit.dart';

//String imageUrl, String title, String time
String imageUrl = '';
bool getImageUrl(article, int index) {
  try {
    imageUrl = '${article[index]['urlToImage']}';
  } catch (e) {
    return false;
  }
  if (article[index]['urlToImage'] == null) return false;
  return true;
}

Widget NewsItemWidget(
    {required List<dynamic> article,
    required int index,
    required BuildContext context}) {
  return InkWell(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (ctx) => Web_View(article[index]['url'])));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Container(
            width: 130,
            height: 130,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                    image: getImageUrl(article, index)
                        ? NetworkImage('${article[index]['urlToImage']}')
                        : NetworkImage(
                            'https://korenainthekitchen.com/wp-content/uploads/2011/02/white1.jpg'),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsetsDirectional.only(start: 10),
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        article[index]['title'] != null
                            ? article[index]['title']
                            : "No Title",
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      article[index]['publishedAt'],
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget defaultFormField({
  required TextEditingController txtcon1,
  Function(String)? onChange,
  Function()? onTap,
  required String lable,
  Color color = Colors.white,
  Icon? pre,
  String? warningMsg,
  bool isPassword = false,
  bool autoFocus = false,
  Icon? suff,
  TextInputType? type,
  Function(String)? onFieldSubmitted,
  Function()? suffOnPressed,
}) =>
    TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChange,
      autofocus: autoFocus,
      onTap: onTap != null ? onTap : () {},
      // textDirection: TextDirection.rtl,
      style: TextStyle(
        color: color,
      ),
      controller: txtcon1,
      validator: (txt) {
        if (txt!.isEmpty) {
          return warningMsg;
        }
        if (txt.length < 4) {
          return 'too small';
        }
      },
      obscureText: isPassword,
      keyboardType: type != null ? type : TextInputType.text,
      decoration: InputDecoration(
        labelText: lable,
        labelStyle: TextStyle(fontSize: 18, color: color),
        prefixIcon: pre != null ? pre : SizedBox(),
        suffixIcon: IconButton(
          onPressed: suffOnPressed,
          icon: suff != null ? suff : SizedBox(),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: BorderSide(
            color: Colors.deepOrange,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: BorderSide(
            color: color,
          ),
        ),
      ),
    );
