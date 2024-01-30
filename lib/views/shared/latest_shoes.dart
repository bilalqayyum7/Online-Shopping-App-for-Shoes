import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:online_shopping_app/models/sneakers_models.dart';
import 'package:online_shopping_app/views/shared/staggar_tile.dart';

class LatestShoes extends StatelessWidget {
  const LatestShoes({super.key,
  required Future<List<Sneakers>> male,}) : _male = male;

  final Future<List<Sneakers>> _male;

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<List<Sneakers>>(
      future: _male,
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        } else if(snapshot.hasError){
          return Text("Error ${snapshot.error}");
        } else {
          final male = snapshot.data;
          return StaggeredGridView.countBuilder(
              padding: EdgeInsets.zero,
              crossAxisCount: 2,
              crossAxisSpacing: 20.w,
              mainAxisSpacing: 20.h,
              itemCount: male!.length,
              scrollDirection: Axis.vertical,
              staggeredTileBuilder: (index)  => StaggeredTile.extent(
                  (index % 2 == 0)? 1:1, (index % 4 ==1 || index % 4 ==3)
                  ? 285.h
                  : 252.h),
              itemBuilder: (context, index){
                final shoes = snapshot.data![index];
                return StaggerTile(
                    imageUrl: shoes.imageUrl[1],
                    name: shoes.name,
                    price: "\$${shoes.price}");
              });
        }
      },
    );
  }
}
