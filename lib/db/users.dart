import 'dart:async';
import 'package:gamersmultiverse/models/cart_items.dart';
import 'package:gamersmultiverse/models/user_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
// In this class we are making a collection in the firebase for users
class UserServices{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = "users";

  createUser(Map<String, dynamic> data) async{
    try{
      await _firestore.collection(collection).doc(data["uid"]).set(data);
      print("USER WAS CREATED");
    }catch(e){
      print('ERROR: ${e.toString()}');
    }


  }

  Future<UserModel> getUserById(String id)=> _firestore.collection(collection).doc(id).get().then((doc){
    print("==========id is $id=============");
    debugPrint("==========NAME is ${doc.data()['name']}=============");
    debugPrint("==========NAME is ${doc.data()['name']}=============");
    debugPrint("==========NAME is ${doc.data()['name']}=============");
    debugPrint("==========NAME is ${doc.data()['name']}=============");

    print("==========NAME is ${doc.data()['name']}=============");
    print("==========NAME is ${doc.data()['name']}=============");
    print("==========NAME is ${doc.data()['name']}=============");


    return UserModel.fromSnapshot(doc);
  });
//This function are made specificly for each user to have their own products in the cart put by themselves
  void addToCart({String userId, CartItemModel cartItem}){
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayUnion([cartItem.toMap()])
    });
  }
//This function are made specificly for each user to have their own products in the cart removed by themselves

  void removeFromCart({String userId, CartItemModel cartItem}){
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayRemove([cartItem.toMap()])
    });
  }
}


