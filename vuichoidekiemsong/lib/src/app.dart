import 'package:flutter/material.dart';

import 'constant/constant.dart';
import 'entity/category.dart';
import 'screens/myhomepage.dart';
import 'screens/postlistpage.dart';
import 'screens/postcontent.dart';
import 'screens/authentication/signuppage.dart';
import 'screens/authentication/loginpage.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constant.appTitle,
      home: MyHomePage(),
      routes: <String, WidgetBuilder> {
        // define the routes
        Constant.VuiChoiDeKiemSongRouteName: (BuildContext context) => new PostListPage(category: new Category("1", "Vui chơi để kiếm sống", "")),
        Constant.XayDungThuongHieuCaNhanRouteName: (BuildContext context) => new PostListPage(category: new Category("2", "Xây dựng thương hiệu cá nhân", "")),
        Constant.LoCopyWriterRouteName: (BuildContext context) => new PostListPage(category: new Category("3", "Lò Copywriter", "")),
        "/admin": (BuildContext context) => new PostContent(),
        "/signup": (BuildContext context) => new SignUpPage(),
        "/homepage": (BuildContext context) => new MyHomePage(),
        "/login": (BuildContext context) => new LoginPage()
      },
    );
  }
}
