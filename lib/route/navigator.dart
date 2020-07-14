import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:jetlinks_app/route/application.dart';
import 'package:jetlinks_app/route/routes.dart';
import 'package:jetlinks_app/utils/base64.dart';

class NavigatorUtils{
  static push(BuildContext context ,String path,{bool replace=false,bool clearStack =false}){
    Application.router.navigateTo(context, path,
    replace: replace,
    clearStack: clearStack,
    transition: TransitionType.native);
  }

  static pushResult(BuildContext context,String path,Function(Object) function,
  {bool replace=false,bool clearStack =false}){
    Application.router.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        transition: TransitionType.native).then((value) {
          if(value==null){
            return;
          }
          function(value);
    }).catchError((error){
      print("$error");
    });
  }

  static void goBack(BuildContext context)=>Navigator.pop(context);

  static void goBrowserPage(BuildContext context,String url){
    url =Base64.encodeBase64(url).replaceAll("/", "/");
    Application.router.navigateTo(context, '${Routes.webView}?web_url=$url',
    replace: false,
    clearStack: false,
    transition: TransitionType.inFromBottom);
  }

  static void goWallPaper(BuildContext context,String imageUrl){
    /// 这里使用替换/主要是路由不支持链接中带有/和&，否则会出错
    imageUrl = Base64.encodeBase64(imageUrl).replaceAll("/", "jetlinks");
    Application.router.navigateTo(context, '${Routes.wallPaper}?image_url=$imageUrl',
    replace: false,
    clearStack: false,
    transition: TransitionType.custom,
    transitionBuilder: Routes.transitionTopToBottom());
  }

  static void goBackWithParams(BuildContext context,result)=>Navigator.pop(context,result);
}