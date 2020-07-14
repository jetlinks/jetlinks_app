import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:jetlinks_app/common/colors.dart';
import 'package:jetlinks_app/common/constant.dart';
import 'package:jetlinks_app/common/styles.dart';
import 'package:jetlinks_app/model/home_tools.dart';
import 'package:jetlinks_app/model/home_wall_paper.dart';
import 'package:jetlinks_app/route/navigator.dart';
import 'package:jetlinks_app/utils/respository.dart';
import 'package:jetlinks_app/utils/toast.dart';
import 'package:jetlinks_app/widget/card_view.dart';
import 'package:jetlinks_app/widget/commom_search_bar.dart';
import 'package:jetlinks_app/widget/header/home_wallpaper_header.dart';
import 'package:jetlinks_app/widget/home_common_card.dart';
import 'package:jetlinks_app/widget/main/main_widgets.dart';
import 'package:rxdart/rxdart.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SearchBarController _searchBarController = new SearchBarController(
    alpha: 0,
    searchBarBg: Color(0x1FFFFFFF),
    appbarTitleColor: colorA8ACBC,
    appbarLeftIcon: 'ic_search_grey',
    appbarRightIcon: 'ic_message_grey'
  );

  bool _isNeedSetAlpha =false;

  GlobalKey<SearchBarState> _mTitleKey = new GlobalKey();


  List<Data> topCards = List();
  List<Data> bottomCards =List();
  List<String> topCardItems =[
    HomeCard.DIET_SPORT_RECORD,
    HomeCard.WISDOM,
    HomeCard.HEALTH_HABITS,
    HomeCard.WEIGHT_RECORD,
  ];

  ScrollController _controller = new ScrollController();

  HomeWallPaper wallPaper;

  double percent =0.0;

  @override
  void initState() {
    super.initState();
    loadData();
    //监听滚动事件，打印滚动位置
    _searchBarController.value.alpha = 0;
    _controller.addListener(() {
      if (_controller.offset < 0) {
        return;
      }
      if (_controller.offset < 100) {
        // 变化头部颜色
        _isNeedSetAlpha = true;
        double alpha = _controller.offset / 100;
        _searchBarController.value.alpha = (255 * alpha).toInt();
        _searchBarController.value.appbarTitleColor = colorA8ACBC;
        _searchBarController.value.searchBarBg = Color(0x1FFFFFFF);
        _searchBarController.value.appbarLeftIcon = "ic_search_grey";
        _searchBarController.value.appbarRightIcon = "ic_message_grey";
        _mTitleKey.currentState.setState(() {}); // 刷新单个控件的状态,防止卡顿
      } else {
        /// 防止多次渲染
        if (_isNeedSetAlpha) {
          _searchBarController.value.appbarLeftIcon = "ic_search_white";
          _searchBarController.value.appbarRightIcon = "ic_message_white";
          _searchBarController.value.appbarTitleColor = Colors.white;
          _searchBarController.value.searchBarBg = color0EB794;
          _searchBarController.value.alpha = 255;
          _mTitleKey.currentState.setState(() {});
          _isNeedSetAlpha = false;
        }
      }
    });
  }

  /// 壁纸、底部定制tab数据
  void loadData() {
    Repository.loadAsset("home_health_tools", fileDir: "home").then((json) {
      HomeTools homeTools = HomeTools.fromJson(Repository.toMap(json));
      topCards = homeTools.data
          .where((item) => item.visible && topCardItems.contains(item.code))
          .toList();
      bottomCards = homeTools.data
          .where((item) => item.visible && !topCardItems.contains(item.code))
          .toList();
      setState(() {});
    });
    Repository.loadAsset("home_wallpaper", fileDir: "home").then((json) {
      wallPaper = HomeWallPaper.fromJson(Repository.toMapForList(json));
      setState(() {});
    });
    // 体重记录圆环动画
    Observable.just(3).delay(new Duration(milliseconds: 3 * 1000)).listen((_) {
      percent = 0.8;
      setState(() {});
    });
  }

  Widget createToolsCards(){
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top: 13,bottom: 30),
        child: CardView(
          margin: EdgeInsets.only(
            left: 17,
            right: 17
          ),
          child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (BuildContext context,int index){
              return Container(
                height: 0.0,
                margin: EdgeInsetsDirectional.only(start: 16,end: 16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: Divider.createBorderSide(context,color: colorEEEFF3),
                  )
                ),
              );
            },
            padding: EdgeInsets.only(top: 0),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context,int index){
              Widget widget;
              if(bottomCards[index].code==HomeCard.EXERCISE){
                // 运动训练
                widget=CommonCard(
                  onPressed: (){
                  ToastUtils.showToast(context, bottomCards[index].name);
                  },
                  title: bottomCards[index].name,
                  iconUrl: 'ic_home_sport',
                  subWidget: RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: '35',style: TextStyles.get11Text_00CDA2()
                      ),
                      TextSpan(
                        text:'M',style: TextStyles.get11TextA8ACBC()
                      ),
                    ]),
                  ),
                );
              } else if (bottomCards[index].code == HomeCard.MEASURE_RECORD) {
                // 围度记录
                widget = CommonCard(
                    onPressed: () {
                      ToastUtils.showToast(context, bottomCards[index].name);
                    },
                    iconUrl: "ic_home_circumference",
                    title: bottomCards[index].name);
              } else if (bottomCards[index].code == HomeCard.STEPS_RECORD) {
                // 步数记录
                widget = CommonCard(
                    onPressed: () {
                      ToastUtils.showToast(context, bottomCards[index].name);
                    },
                    iconUrl: "ic_home_step",
                    title: bottomCards[index].name);
              } else if (bottomCards[index].code == HomeCard.BABY) {
                // 宝宝记录
                widget = CommonCard(
                    onPressed: () {
                      ToastUtils.showToast(context, bottomCards[index].name);
                    },
                    iconUrl: "ic_home_baby",
                    title: bottomCards[index].name);
              } else if (bottomCards[index].code == HomeCard.DIET_PLAN) {
                // 饮食计划
                widget = CommonCard(
                    onPressed: () {
                      ToastUtils.showToast(context, bottomCards[index].name);
                    },
                    iconUrl: "ic_home_food_plan",
                    title: bottomCards[index].name);
              } else if (bottomCards[index].code == HomeCard.SLEEP_RECORD) {
                // 睡眠记录
                widget = CommonCard(
                    onPressed: () {
                      ToastUtils.showToast(context, bottomCards[index].name);
                    },
                    iconUrl: "ic_home_sleep",
                    title: bottomCards[index].name);
              } else if (bottomCards[index].code == HomeCard.PERIODS_RECORD) {
                // 经期记录
                widget = CommonCard(
                    onPressed: () {
                      ToastUtils.showToast(context, bottomCards[index].name);
                    },
                    iconUrl: "ic_home_menstruation",
                    title: bottomCards[index].name);
              }
              return widget;
            },
            itemCount: bottomCards.length,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        EasyRefresh.custom(
          header: WallPaperHeader(
              wallPaperUrl:
              wallPaper != null ? wallPaper.welcomeImg.backImg : ""),
          scrollController: _controller,
          onRefresh: () async {
            NavigatorUtils.goWallPaper(
                context, wallPaper != null ? wallPaper.welcomeImg.backImg : "");
          },
          slivers: <Widget>[
            SliverToBoxAdapter(
                child: HomeHeaderWidget(
                  /// 壁纸+减肥进度条Widget
                  wallImg:
                  wallPaper != null ? wallPaper.welcomeImg.backImgSmall : "",
                  progressPercent: percent,
                )),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      Widget widget;
                      if (topCards[index].code == HomeCard.DIET_SPORT_RECORD) {
                        /// 饮食运动记录
                        widget = DietSportRecordWidget(
                          topCard: topCards[index],
                        );
                      } else if (topCards[index].code == HomeCard.WISDOM) {
                        /// 智慧营养师
                        widget = WisdomWidget(
                          topCard: topCards[index],
                        );
                      } else if (topCards[index].code == HomeCard.WEIGHT_RECORD) {
                        /// 体重记录
                        widget = WeightRecordWidget(
                          topCard: topCards[index],
                        );
                      } else if (topCards[index].code == HomeCard.HEALTH_HABITS) {
                        widget = HealthHabitsWidget(
                          iconUrl: "ic_home_habit",
                          title: "故障处理",
                        );
                      }
                      return widget;
                    }, childCount: topCards.length)),
            createToolsCards()
          ],
        ),
        SearchBar(
          text: "搜索设备和协议",
          controller: _searchBarController,
          key: _mTitleKey,
        )
      ],
    );
  }
}
