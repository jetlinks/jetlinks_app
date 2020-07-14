import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:jetlinks_app/route/route_handlers.dart';

class Routes{
  static String root ='/home';

  static String login = '/login';

  static String webView = '/browserweb';

  static String wallPaper = '/wallPaper';

  static void configureRoutes(Router router){
    router.define(root, handler: rootHandler);
    router.define(login, handler: loginHandler);
    router.define(webView, handler: webViewHandler);
    router.define(wallPaper, handler: wallPaperHandler);
  }

  static RouteTransitionsBuilder transitionTopToBottom(){
    return (BuildContext context,Animation<double> animation,
    Animation<double> secondaryAnimation,Widget child){
      const Offset begin = const Offset(0.0, -1.0);
      const Offset end = const Offset(0.0, 0.0);

      return SlideTransition(
        position: Tween<Offset>(
          begin: begin,
          end: end,
        ).animate(animation),
        child: child,
      );
    };
  }
}