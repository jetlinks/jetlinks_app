import 'package:json_annotation/json_annotation.dart';

part 'splash_ad.g.dart';


List<SplashAd> getSplashAdList(List<dynamic> list){
  List<SplashAd> result = [];
  list.forEach((item){
    result.add(SplashAd.fromJson(item));
  });
  return result;
}
@JsonSerializable()
class SplashAd extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'start_up_url')
  String startUpUrl;

  @JsonKey(name: 'is_ad')
  bool isAd;

  @JsonKey(name: 'text')
  String text;

  @JsonKey(name: 'link')
  String link;

  @JsonKey(name: 'pop_ads')
  List<dynamic> popAds;

  SplashAd(this.id,this.startUpUrl,this.isAd,this.text,this.link,this.popAds,);

  factory SplashAd.fromJson(Map<String, dynamic> srcJson) => _$SplashAdFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SplashAdToJson(this);

}

