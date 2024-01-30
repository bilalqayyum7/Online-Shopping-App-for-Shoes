
import 'package:online_shopping_app/views/shared/export.dart';
import 'package:online_shopping_app/views/shared/export_pakages.dart';

import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  final String id;
  final String category;
  const ProductPage({super.key, required this.id, required this.category});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    productNotifier.getShoes(widget.category, widget.id);
    var cartProvider = Provider.of<CartProvider>(context);
    var favouriteNotifier = Provider.of<FavouriteNotifier>(context, listen: true);
    favouriteNotifier.getFavourites();
    return Scaffold(
        body: FutureBuilder<Sneakers>(
            future: productNotifier.sneaker,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error ${snapshot.error}");
              } else {
                final sneaker = snapshot.data;
                return Consumer<ProductNotifier>(
                  builder: (context, productNotifier, child) {
                    return CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          leadingWidth: 0,
                          title: Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                   // productNotifier.shoeSize.clear();
                                  },
                                  child: Icon(
                                    Ionicons.close,
                                    color: Colors.black,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: null,
                                  child: Icon(
                                    Ionicons.ellipsis_horizontal,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          pinned: true,
                          snap: false,
                          floating: true,
                          backgroundColor: Colors.transparent,
                          expandedHeight: MediaQuery.of(context).size.height,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Stack(
                              children: [
                                SizedBox(
                                  height: 401.h,
                                  width: 375.w,
                                  child: PageView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: sneaker!.imageUrl.length,
                                      controller: pageController,
                                      onPageChanged: (page) {
                                        productNotifier.activePage = page;
                                      },
                                      itemBuilder: (context, int index) {
                                        return Stack(
                                          children: [
                                            Container(
                                              height: 316.h,
                                              width: 375.w,
                                              color: Colors.grey.shade300,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    sneaker.imageUrl[index],
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Positioned(
                                                top: 98.h,
                                                right: 20.w,
                                                child: Consumer<FavouriteNotifier>(
                                                  builder: (context, favouritesNotifier, child){
                                                    return GestureDetector(
                                                      onTap: (){
                                                        if (favouritesNotifier.ids.contains(widget.id)){
                                                          Navigator.push(context,
                                                          MaterialPageRoute(builder: (context)
                                                          => Favourite()));
                                                        }else {
                                                          favouriteNotifier.createFav({
                                                            "id": sneaker.id,
                                                            "name": sneaker.name,
                                                            "category": sneaker.category,
                                                            "price": sneaker.price,
                                                            "imageUrl": sneaker.imageUrl[0],

                                                          });
                                                        }
                                                        setState(() {

                                                        });
                                                      },
                                                      child: favouritesNotifier.ids.contains(sneaker.id) ?
                                                      Icon(AntDesign.heart): Icon(AntDesign.hearto),
                                                    );
                                                  },
                                                )
                                            ),
                                            Positioned(
                                                bottom: 0,
                                                right: 0,
                                                left: 0,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.3,
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children:
                                                        List<Widget>.generate(
                                                      sneaker.imageUrl.length,
                                                      (index) => Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      4),
                                                          child: CircleAvatar(
                                                            radius: 5,
                                                            backgroundColor:
                                                                productNotifier
                                                                            .activepage !=
                                                                        index
                                                                    ? Colors
                                                                        .grey
                                                                    : Colors
                                                                        .black,
                                                          )),
                                                    ))),

                                          ],
                                        );
                                      }),
                                ),
                                Positioned(
                                    bottom: 30,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30)
                                      ),
                                      child: Container(
                                        height: MediaQuery.of(context).size.height*0.645,
                                        width: MediaQuery.of(context).size.width,
                                        color: Colors.white,
                                        child: Padding(
                                          padding: EdgeInsets.all(12),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(sneaker.name,
                                                style: appstyle(40, Colors.black, FontWeight.bold),),
                                              Row(
                                                children: [
                                                  Text(sneaker.category,
                                                  style: appstyle(20, Colors.grey, FontWeight.w500),),
                                                  SizedBox(width: 20,),
                                                  RatingBar.builder(
                                                    initialRating: 4,
                                                      minRating: 1,
                                                      direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                     itemCount: 5,
                                                    itemSize: 22,
                                                    itemPadding: EdgeInsets.symmetric(horizontal: 1),
                                                    itemBuilder: (context, _) => Icon(Icons.star,
                                                    size: 18, color: Colors.black,),
                                                    onRatingUpdate: (rating){},

                                                      )
                                                ],
                                              ),
                                              SizedBox(height: 20,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                   Text("\$${sneaker.price}",
                                                   style: appstyle(25, Colors.black, FontWeight.w600),),
                                                  Row(
                                                    children: [
                                                      Text("Colors",
                                                        style: appstyle(18, Colors.black, FontWeight.w500),),
                                                      SizedBox(width: 5,),
                                                      const CircleAvatar(
                                                        radius: 7, backgroundColor: Colors.black,
                                                      ),
                                                      SizedBox(width: 5,),
                                                      const CircleAvatar(
                                                        radius: 7, backgroundColor: Colors.black,
                                                      )

                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 20,),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text("Select size",
                                                      style: appstyle(20, Colors.black, FontWeight.w600),),
                                                      SizedBox(width: 20,),
                                                      Text("View size guide",
                                                        style: appstyle(20, Colors.grey, FontWeight.w600),),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10,),
                                                  SizedBox(
                                                    height: 40,
                                                    child: ListView.builder(
                                                        itemCount: productNotifier.shoeSize.length,
                                                        scrollDirection: Axis.horizontal,
                                                        padding: EdgeInsets.zero,
                                                        itemBuilder: (context, index){
                                                          final sizes = productNotifier.shoeSize[index];
                                                      return Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                                        child: ChoiceChip(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(60),
                                                            side: BorderSide(
                                                              color: Colors.black,
                                                              width: 1,
                                                              style: BorderStyle.solid,
                                                            )
                                                          ),
                                                            disabledColor: Colors.white,
                                                            label: Text(sizes['size'],
                                                            style: appstyle(18, sizes['isSelected']?Colors.white
                                                                : Colors.black, FontWeight.w500),),
                                                            selected: sizes['isSelected'],
                                                        onSelected: (newState){
                                                            if(productNotifier.sizes.contains(sizes['size'])){
                                                              productNotifier.sizes.remove(sizes['size']);
                                                            } else {
                                                              productNotifier.sizes.add(sizes['size']);
                                                              print(productNotifier.sizes);
                                                              productNotifier.toggleCheck(index);
                                                            }
                                                        },),
                                                      );
                                                    }),
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 10,),
                                              Divider(indent: 10, endIndent: 10, color: Colors.black,),
                                              SizedBox(height: 10,),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width*0.8,
                                                child: Text(sneaker.title,
                                                style: appstyle(26, Colors.black, FontWeight.w700),),
                                              ),
                                              SizedBox(height: 10,),
                                              Text(sneaker.description,
                                              textAlign: TextAlign.justify,
                                              maxLines: 4,style: appstyle(14, Colors.black, FontWeight.normal),
                                              ),
                                              SizedBox(height: 10,),
                                              Align(
                                                alignment: Alignment.bottomCenter,
                                                child: Padding(
                                                  padding: EdgeInsets.only(top: 12),
                                                  child: CheckoutButton(
                                                    onTap: () async{
                                                      productNotifier.sizes.clear();
                                                      Navigator.pop(context);
                                                    },
                                                    label: "Add to Cart",
                                                  )
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                );
              }
            }));
  }
}
