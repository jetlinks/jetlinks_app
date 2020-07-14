import 'package:flustars/flustars.dart';
import 'package:jetlinks_app/common/constant.dart';
import 'package:jetlinks_app/model/login_user.dart';

class AccountUtils{
  static User mUser;
  static bool isLogin(){
    String token = SpUtil.getString(Constant.token,defValue: "");
    return token.isNotEmpty;
  }

  static void saveUser(LoginUser user){
    SpUtil.putObject(Constant.login_user, user);
  }

  static User getUser(){
    if(mUser==null){
      mUser=SpUtil.getObj(Constant.login_user, (v) => LoginUser.fromJson(v)).user;
    }
    return mUser;
  }
}