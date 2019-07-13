import 'package:flutter/material.dart';
import 'package:wan_android_flutter/res/MyColors.dart';

class MainDart extends StatefulWidget {
  @override
  _MainDartState createState() => _MainDartState();
}

class _MainDartState extends State<MainDart>
    with SingleTickerProviderStateMixin {
  int positionIndex = 0;
  var mainTitle = ["首页", "发现", "其他", "我的"];
  var indexStack;
  List<BottomNavigationBarItem> navigationViews;

  //定义一个globalkey  外部可以访问这个widget的方法，改变状态
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _initNavigationBarView();
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false, //去除debug标签
      theme: ThemeData(
        accentColor: Colors.black,
        textSelectionColor: MyColors.colorWhite,
        primaryColor: MyColors.colorPrimary,
      ),
      home: Scaffold(
        appBar: _initAppBar(),
        bottomNavigationBar: _initNavigationBar(),
        drawer: _initDrawer(),
      ),
    );
  }

  AppBar _initAppBar() {
    return AppBar(
      title: Text(
        mainTitle[positionIndex],
        style: new TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      automaticallyImplyLeading: false, //去掉前面的icon

      //android 上的meun
      actions: <Widget>[
        IconButton(icon: Icon(Icons.account_balance), onPressed: () {}),
        IconButton(icon: Icon(Icons.search), onPressed: () {}),
        IconButton(icon: Icon(Icons.settings), onPressed: () {})
      ],
    );
  }

  BottomNavigationBar _initNavigationBar() {
    return new BottomNavigationBar(
      items: navigationViews
          .map((BottomNavigationBarItem navigationView) => navigationView)
          .toList(),
      currentIndex: positionIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() {
          positionIndex = index;
        });
      },
    );
  }

  void initData() {}

  void _initNavigationBarView() {
    navigationViews = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(mainTitle[0]),
          backgroundColor: Colors.black),
      BottomNavigationBarItem(
          icon: Icon(Icons.assignment),
          title: Text(mainTitle[1]),
          backgroundColor: Colors.black),
      BottomNavigationBarItem(
          icon: Icon(Icons.devices_other),
          title: Text(mainTitle[2]),
          backgroundColor: Colors.black),
      BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text(mainTitle[3]),
          backgroundColor: Colors.black),
    ];
  }

  Drawer _initDrawer() {
    return Drawer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text('wanandroid'),
          accountEmail: Text('768712849@qq.com'),
          onDetailsPressed: () {
            //todo 跳转到我的界面
          },
          currentAccountPicture: GestureDetector(
            child: Image.asset(
              'assets/images/ic_launcher_round.png',
              fit: BoxFit.fill,
            ),
            onTap: (){
              //todo 跳转到我的界面
            },
          ),
        ),

      ],
    ));
  }
}
