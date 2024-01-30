
import 'package:online_shopping_app/controller/product_provider.dart';
import 'package:online_shopping_app/views/shared/custom_spacer.dart';
import 'package:online_shopping_app/views/shared/export.dart';
import 'package:online_shopping_app/views/shared/export_pakages.dart';
import 'package:online_shopping_app/views/shared/latest_shoes.dart';
import 'package:provider/provider.dart';

class ProductByCart extends StatefulWidget {
  final int tabIndex;
  const ProductByCart({super.key, required this.tabIndex});

  @override
  State<ProductByCart> createState() => _ProductByCartState();
}

class _ProductByCartState extends State<ProductByCart>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);



  @override
  void initState() {
    super.initState();
    _tabController.animateTo(widget.tabIndex,);
  }

  @override
  void dispose(){
    super.dispose();
    _tabController.dispose();
  }

  List<String> brand = [
    "assets/images/adidas.png",
    "assets/images/gucci.png",
    "assets/images/jordan.png",
    "assets/images/nike.png",
  ];

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    productNotifier.geFemale();
    productNotifier.getMale();
    productNotifier.getKids();
    return Scaffold(
      backgroundColor: Color(0xFFE2E2E2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 16.w, top: 45.h),
              height: 325.h,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/images/top_image.png",
                      ),
                      fit: BoxFit.fill)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(6.w, 12.h, 16.w, 18.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            AntDesign.close,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            filter();
                          },
                          child: Icon(
                            FontAwesome.sliders,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
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
                        Tab(
                          text: "Men Shoes",
                        ),
                        Tab(
                          text: "Women Shoes",
                        ),
                        Tab(
                          text: "Kids Shoes",
                        ),
                      ]),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.175,
                left: 16,
                right: 12,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: TabBarView(controller: _tabController, children: [
                  LatestShoes(male: productNotifier.male),
                  LatestShoes(male: productNotifier.female),
                  LatestShoes(male: productNotifier.kids),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> filter() {
    double _value = 100;
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white54,
        context: context,
        builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.84,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 5,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.black38,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Column(
                      children: [
                        CustomSpacer(),
                        Text(
                          "Filter",
                          style: appstyle(35, Colors.black, FontWeight.bold),
                        ),
                        const CustomSpacer(),
                        Text(
                          "Gender",
                          style: appstyle(18, Colors.black, FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                               CategoryBtn(buttonClr: Colors.black,
                                   label: "Men", onPress: (){}),
                            CategoryBtn(buttonClr: Colors.grey,
                                label: "Women", onPress: (){}),
                            CategoryBtn(buttonClr: Colors.grey,
                                label: "Kids", onPress: (){}),
                          ],
                        ),
                        CustomSpacer(),
                        Text("Category",
                          style: appstyle(18, Colors.black, FontWeight.w600),),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            CategoryBtn(buttonClr: Colors.black,
                                label: "Shoes", onPress: (){},),
                            CategoryBtn(buttonClr: Colors.grey,
                                label: "Apparrels", onPress: (){}),
                            CategoryBtn(buttonClr: Colors.grey,
                                label: "Accessories", onPress: (){}),
                          ],
                        ),
                        CustomSpacer(),
                        Text("Price",
                          style: appstyle(18, Colors.black, FontWeight.w600),),
                        Slider(value: _value,
                            activeColor: Colors.black,
                            inactiveColor: Colors.grey,
                            thumbColor: Colors.black,
                            max: 500,
                            divisions: 50,
                            label: _value.toString(),
                            secondaryTrackValue: 200,
                            onChanged: (double value){

                            }),

                        Text("Brand",
                          style: appstyle(18, Colors.black, FontWeight.w600),),
                        SizedBox(height: 15,),
                        Container(
                          padding: EdgeInsets.all(8),
                          height: 80,
                          child: ListView.builder(
                            itemCount: brand.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index){
                                return Padding(
                                    padding: EdgeInsets.all(8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.all(Radius.circular(12)),
                                    ),
                                    child: Image.asset(brand[index],
                                    height: 60,
                                    width: 80,
                                    color: Colors.black,),
                                  ),
                                );
                              }),
                        )

                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}
