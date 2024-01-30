import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:online_shopping_app/controller/main_secreen_provider.dart';
import 'package:online_shopping_app/views/shared/bottom_nav_widget.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainSecreenNotifier>(
        builder: (context, mainSecreenNotifier, child){
          return SafeArea(
            child: Padding(padding: EdgeInsets.all(10),
              child: Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(16))
                ),
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BottomNavWidget(
                        onTap: (){
                          mainSecreenNotifier.pageIndex = 0;
                        },
                        icon: mainSecreenNotifier.pageIndex == 0
                            ?MaterialCommunityIcons.home
                            :MaterialCommunityIcons.home_outline),
                    BottomNavWidget(
                        onTap: (){
                          mainSecreenNotifier.pageIndex = 1;
                        },
                        icon: mainSecreenNotifier.pageIndex == 1
                            ?Ionicons.search : Ionicons.search ),
                    BottomNavWidget(
                        onTap: (){
                          mainSecreenNotifier.pageIndex = 2;
                        },
                        icon: mainSecreenNotifier.pageIndex == 2
                            ?Ionicons.heart : Ionicons.heart_circle_outline ),
                    BottomNavWidget(
                        onTap: (){
                          mainSecreenNotifier.pageIndex = 3;
                        },
                        icon: mainSecreenNotifier.pageIndex == 3
                            ?Ionicons.cart : Ionicons.cart_outline ),
                    BottomNavWidget(
                        onTap: (){
                          mainSecreenNotifier.pageIndex = 4;
                        },
                        icon: mainSecreenNotifier.pageIndex == 4
                            ?Ionicons.person : Ionicons.person_outline ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
