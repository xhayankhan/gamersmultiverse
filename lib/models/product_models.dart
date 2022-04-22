import 'package:cloud_firestore/cloud_firestore.dart';
//In this class we are initializing, setting getters and maping all the properties of products


class ProductModel {
  static const ID = "id";
  static const NAME = "name";
  static const IMAGES = "images";
  static const PRICE = "price";
  static const DESCRIPTION = "description";
  static const CATEGORY_NAME = "categoryName";
 // static const FEATURED = "featured";
  static const QUANTITY = "quantity";
 // static const SALE = "sale";


  String _id;
  String _name;
  String _images;
  String _description;
  String _categoryName;
  int _quantity;
  int _price;
 // bool _sale;
 // bool _featured;


  String get id => _id;
  String get name => _name;
  String get images => _images;
  String get categoryName => _categoryName;
  String get description => _description;
  int get quantity => _quantity;
  int get price => _price;
 // bool get featured => _featured;
 // bool get sale => _sale;



  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()[ID];
   // _sale = snapshot.data()[SALE];
   _description = snapshot.data()[DESCRIPTION] ?? " ";
   // _featured = snapshot.data()[FEATURED];
    _price = snapshot.data()[PRICE].floor();
    _categoryName = snapshot.data()[CATEGORY_NAME];
    _name = snapshot.data()[NAME];
    _images = snapshot.data()[IMAGES];
    _quantity = snapshot.data()[QUANTITY];

  }
}