import 'package:flutter/cupertino.dart';
import 'package:online_shopping_app/models/sneakers_models.dart';
import 'package:online_shopping_app/services/helper.dart';

class ProductNotifier extends ChangeNotifier{
  int _activepage = 0;
  List<dynamic> _shoeSize = [];
  List<String> _sizes = [];

  int get activepage => _activepage;

  set activePage(int newIndex){
    _activepage = newIndex;
    notifyListeners();
  }

  List<dynamic> get shoeSize => _shoeSize;

  set shoesSizes(List<dynamic> newSize){
    _shoeSize = newSize;
    notifyListeners();
  }

  void toggleCheck(int index) {
    for(int i = 0; i<_shoeSize.length; i++){
      if(i == index){
        _shoeSize[i]['isSelected'] = !_shoeSize[i]['isSelected'];
      }
    }
    notifyListeners();
  }

  List<String> get sizes => _sizes;
  set sizes(List<String> newSizes){
    _sizes = newSizes;
    notifyListeners();
  }

  late Future<List<Sneakers>> male;
  late Future<List<Sneakers>> female;
  late Future<List<Sneakers>> kids;
  late Future<Sneakers> sneaker;

  void getMale(){
    male = Helper().getMaleSneakers();
  }
  void geFemale(){
    female = Helper().getFemaleSneakers();
  }
  void getKids(){
    kids = Helper().getKidsSneakers();
  }

  late Future<Sneakers> _sneaker;

  void getShoes(String category, String id) {
    if (category == "Men's Running") {
      sneaker = Helper().getMaleSneakersById(id);
    } else if (category == "Women's Running") {
      sneaker = Helper().getFemaleSneakersById(id);
    } else {
      sneaker = Helper().getKidsSneakersById(id);
    }
  }
}