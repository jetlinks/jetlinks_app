import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:jetlinks_app/views/common/browser_page.dart';
import 'package:jetlinks_app/views/common/wallpaper.dart';
import 'package:jetlinks_app/views/login/login_page.dart';
import 'package:jetlinks_app/views/main_page.dart';

var rootHandler = new Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params)=>new MainPage()
);

var loginHandler = new Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params)=>new LoginPage()
);

var webViewHandler = new Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params)=>new BrowserPage(
    webViewUrl: params['web_url']?.first,
  )
);

var wallPaperHandler = new Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params)=>new WallPagerPage(
      wallpaperImageUrl: params['image_url']?.first)
);