import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jetlinks_app/route/application.dart';
import 'package:jetlinks_app/route/routes.dart';
import 'package:jetlinks_app/splash_page.dart';

class RouteComponent extends StatefulWidget {
  @override
  _RouteComponentState createState() => _RouteComponentState();
}

class _RouteComponentState extends State<RouteComponent> {
  _RouteComponentState(){
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router=router;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,scaffoldBackgroundColor: Colors.white
      ),
      home:SplashPage(),
    );
  }
}
