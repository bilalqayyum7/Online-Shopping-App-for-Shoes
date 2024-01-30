
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping_app/controller/product_provider.dart';
import 'package:online_shopping_app/models/sneakers_models.dart';
import 'package:online_shopping_app/services/helper.dart';
import 'package:online_shopping_app/views/shared/app_style.dart';
import 'package:online_shopping_app/views/shared/home_widget.dart';
import 'package:online_shopping_app/views/shared/reusable_test.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  late final TabController _tabController = TabController(
      length: 3, vsync: this);


  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    productNotifier.getMale();
    productNotifier.geFemale();
    productNotifier.getKids();

    var favouriteNotifier = Provider.of<ProductNotifier>(context);
    return Scaffold(
        backgroundColor: Color(0xFFE2E2E2),
      body: SizedBox(
        height: 812.h,
        width: 375.w,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 15.h, 0, 0),
              height: 325.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/top_image.png",),
                  fit: BoxFit.fill
                )
              ),
              child: Container(
                padding: EdgeInsets.only(left: 8.w, bottom: 15.h),
                width: 375.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(text: "Athletics Shoes",
                      style: appstyleWithHt(
                        42, Colors.white, FontWeight.bold, 1.2),),
                    ReusableText(text: "Collection",
                      style: appstyleWithHt(
                        42, Colors.white, FontWeight.bold, 1.2),),
                    TabBar(
                      padding: EdgeInsets.zero,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: Colors.transparent,
                        controller: _tabController,
                        isScrollable: true,
                        labelColor: Colors.white,
                        labelStyle: appstyle(24, Colors.white, FontWeight.bold),
                        unselectedLabelColor: Colors.grey.withOpacity(0.3),
                        tabs: [
                          Tab(text: "Men Shoes",),
                          Tab(text: "Women Shoes",),
                          Tab(text: "Kids Shoes",),
                        ]),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                  top: 203.h),
              child: Container(
                padding: EdgeInsets.only(left: 12.w,),
                child: TabBarView(
                  controller: _tabController,
                    children: [
                      HomeWidget(male: productNotifier.male,
                        tabIndex: 0,),
                      HomeWidget(male: productNotifier.female,
                        tabIndex: 1,),
                      HomeWidget(male: productNotifier.kids,
                        tabIndex: 2,),
                    ]
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}

