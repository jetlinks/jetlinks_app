import 'package:json_annotation/json_annotation.dart';

part 'login_user.g.dart';


@JsonSerializable()
class LoginUser extends Object {

  @JsonKey(name: 'user')
  User user;

  @JsonKey(name: 'token')
  String token;

  LoginUser(this.user,this.token,);

  factory LoginUser.fromJson(Map<String, dynamic> srcJson) => _$LoginUserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LoginUserToJson(this);

}


@JsonSerializable()
class User extends Object {

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'username')
  String username;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'type')
  String type;

  User(this.id,this.username,this.name,this.type,);

  factory User.fromJson(Map<String, dynamic> srcJson) => _$UserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserToJson(this);

}


