import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:online_shopping_app/controller/main_secreen_provider.dart';
import 'package:online_shopping_app/views/shared/bottom_nav_bar.dart';
import 'package:online_shopping_app/views/shared/bottom_nav_widget.dart';
import 'package:online_shopping_app/views/shared/home_widget.dart';
import 'package:online_shopping_app/views/ui/cart.dart';
import 'package:online_shopping_app/views/ui/cart_page.dart';
import 'package:online_shopping_app/views/ui/favourite.dart';
import 'package:online_shopping_app/views/ui/home_page.dart';
import 'package:online_shopping_app/views/ui/product_by_cart.dart';
import 'package:online_shopping_app/views/ui/profile_page.dart';
import 'package:online_shopping_app/views/ui/search_page.dart';
import 'package:provider/provider.dart';

import '../shared/app_style.dart';

class MainSecreen extends StatelessWidget {
  MainSecreen({super.key});

  List<Widget> pageList = [
    HomePage(),
    SearchPage(),
    Favourite(),
    CartP(),
    ProfilePage(),

  ];

  @override
  Widget build(BuildContext context) {


    return Consumer<MainSecreenNotifier>(
        builder: (context, mainSecreenNotifier, child){
          return Scaffold(
            backgroundColor: Color(0xFFE2E2E2),
            body: pageList[mainSecreenNotifier.pageIndex],
            bottomNavigationBar: BottomNavBar(),

          );
        });
  }
}
