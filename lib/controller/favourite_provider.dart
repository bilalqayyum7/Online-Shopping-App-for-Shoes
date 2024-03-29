import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class FavouriteNotifier extends ChangeNotifier{
  final _favBox = Hive.box('fav_box');
  List<dynamic> _ids = [];

  List<dynamic> _favourites = [];
  List<dynamic> _fav = [];

  List<dynamic> get ids => _ids;

  set ids(List<dynamic> newIds){
    _ids = newIds;
    notifyListeners();
  }

  List<dynamic> get favourites => _favourites;

  set favourites(List<dynamic> newFav){
    _favourites = newFav;
    notifyListeners();
  }

  List<dynamic> get fav => _fav;

  set fav(List<dynamic> newFav){
    _fav = newFav;
    notifyListeners();
  }


  getFavourites(){
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);

      return {
        "key": key,
        "id": "id",
      };
    }).toList();

    _favourites = favData.toList();
    _ids = _favourites.map((item) => item['id']).toList();
  }

  getAllData(){
    List<dynamic> fav = [];
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);

      return {
        "key": key,
        "id": item['id'],
        "name": item['name'],
        "category": item['category'],
        "price": item['price'],
        "imageUrl": item['imageUrl'],
      };
    }).toList();
    _fav = favData.reversed.toList();
  }
  Future<void>deleteFav(int key) async {
    await _favBox.delete(key);
  }

  Future<void> createFav(Map<String, dynamic> addFav) async{
    await _favBox.add(addFav);
  }
}