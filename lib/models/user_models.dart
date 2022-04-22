import 'package:cloud_firestore/cloud_firestore.dart';
//In this class we are initializing, setting getters and maping all the properties of users

import 'cart_items.dart';

class UserModel {
  static const ID = "uid";
  static const NAME = "name";
  static const EMAIL = "email";
  static const CART = "cart";


  String _name;
  String _email;
  String _id;
  int _priceSum = 0;


//  getters
  String get name => _name;

  String get email => _email;

  String get id => _id;


  // public variables
  List<CartItemModel> cart;
  int totalCartPrice;



  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data()[NAME];
    _email = snapshot.data()[EMAIL];
    _id = snapshot.data()[ID];
    cart = _convertCartItems(snapshot.data()[CART]?? []);
    totalCartPrice = snapshot.data()[CART] == null ? 0 :getTotalPrice(cart: snapshot.data()[CART]);

  }

  List<CartItemModel> _convertCartItems(List cart){
    List<CartItemModel> convertedCart = [];
    for(Map cartItem in cart){
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }

  int getTotalPrice({List cart}){
    if(cart == null){
      return 0;
    }
    for(Map cartItem in cart){
      _priceSum += cartItem["price"];
    }

    int total = _priceSum;
    return total;
  }
}