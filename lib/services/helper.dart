
import 'package:online_shopping_app/models/sneakers_models.dart';
import 'package:flutter/services.dart';
// this class fetches data from json file
class Helper{
  // for Male
  Future<List<Sneakers>> getMaleSneakers() async{
    final data = await rootBundle.loadString("assets/json/men_shoes.json");

    final maleList = sneakersFromJson(data);

    return maleList;
  }

  // for Female
  Future<List<Sneakers>> getFemaleSneakers() async{
    final data = await rootBundle.loadString("assets/json/women_shoes.json");

    final femaleList = sneakersFromJson(data);

    return femaleList;
  }

  // for Kids
  Future<List<Sneakers>> getKidsSneakers() async{
    final data = await rootBundle.loadString("assets/json/kids_shoes.json");

    final kidsList = sneakersFromJson(data);

    return kidsList;
  }

  // single Male
  Future<Sneakers> getMaleSneakersById(String id) async{
    final data = await rootBundle.loadString("assets/json/men_shoes.json");

    final maleList = sneakersFromJson(data);
    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);

    return sneaker;
  }

  // single Female
  Future<Sneakers> getFemaleSneakersById(String id) async{
    final data = await rootBundle.loadString("assets/json/women_shoes.json");

    final maleList = sneakersFromJson(data);
    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);

    return sneaker;
  }

  // single Kids
  Future<Sneakers> getKidsSneakersById(String id) async{
    final data = await rootBundle.loadString("assets/json/kids_shoes.json");

    final maleList = sneakersFromJson(data);
    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);

    return sneaker;
  }
}