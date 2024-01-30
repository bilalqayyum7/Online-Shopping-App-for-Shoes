import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';
import 'package:online_shopping_app/controller/favourite_provider.dart';
import 'package:online_shopping_app/models/constant.dart';
import 'package:online_shopping_app/views/shared/app_style.dart';
import 'package:online_shopping_app/views/ui/main_secreen.dart';
import 'package:provider/provider.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {




  @override
  Widget build(BuildContext context) {
    var favouriteNotifier = Provider.of<FavouriteNotifier>(context);
    favouriteNotifier.getAllData();
    return Scaffold(
        body: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, 15, 0, 0),
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/top_image.png",),
                    fit: BoxFit.fill)),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text( "My Favourite",
                style: appstyle(36, Colors.black, FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: favouriteNotifier.fav.length,
                padding: EdgeInsets.only(top: 100),
                itemBuilder: (BuildContext context, int index) {
                final shoe = favouriteNotifier.fav[index];
                return Padding(padding: EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12),),
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.11,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade500,
                          spreadRadius: 5,
                          blurRadius: 0.3,
                          offset: Offset(0, 1),
                        )
                      ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(padding: EdgeInsets.all(12),
                              child: CachedNetworkImage(
                                imageUrl: shoe['imageUrl'],
                                width: 70,
                                height: 70,
                                fit: BoxFit.fill,
                              ),),
                            Padding(padding: EdgeInsets.only(top: 12, left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(shoe['name'],
                                    style: appstyle(16, Colors.black, FontWeight.bold),),
                                  SizedBox(height: 5,),
                                  Text(shoe['category'],
                                    style: appstyle(14, Colors.grey, FontWeight.w600),),
                                  SizedBox(height: 5,),
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${shoe['price']}",
                                        style: appstyle(18, Colors.black, FontWeight.w600),)
                                    ],
                                  )
                                ],
                              ),),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(8),
                        child: GestureDetector(
                          onTap: (){
                            favouriteNotifier.deleteFav(shoe['key']);
                            favouriteNotifier.ids.removeWhere((element) => element == shoe['id']);
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) => MainSecreen()));
                          },
                          child: Icon(Ionicons.md_heart_dislike),
                        ),)
                      ],
                    ),
                  ),
                ),);
                }),
          )
        ],
      ),
    ));
  }
}
