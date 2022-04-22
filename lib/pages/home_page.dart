import 'package:gamersmultiverse/commons/common.dart';
import 'package:gamersmultiverse/provider/product.dart';
import 'package:gamersmultiverse/provider/user_provider.dart';
import 'package:gamersmultiverse/pages/product_search.dart';
import 'package:gamersmultiverse/db/product.dart';
import 'package:gamersmultiverse/widgets/custom_text.dart';
import 'package:gamersmultiverse/widgets/featured_products.dart';
import 'package:gamersmultiverse/widgets/product_card.dart';
import 'package:gamersmultiverse/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

import 'cart.dart';
import 'order.dart';
//This is the homepage screen
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _key = GlobalKey<ScaffoldState>();
  ProductServices _productServices = ProductServices();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      key: _key,
      backgroundColor: Colors.grey.shade900,
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              accountName: CustomText(
                text: userProvider.userModel?.name ?? "username lading...",
                color: Colors.white,
                weight: FontWeight.bold,
                size: 18,
              ),
              accountEmail: CustomText(
                text: userProvider.userModel?.email ?? "email loading...",
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () async{
                await userProvider.getOrders();
                changeScreen(context, OrdersScreen());
              },
              leading: Icon(Icons.bookmark_border),
              title: CustomText(text: "My orders",color: Colors.white,)
            ),

            ListTile(
              onTap: () {
                userProvider.signOut();
              },
              leading: Icon(Icons.exit_to_app),
              title: CustomText(text: "Log out",color: Colors.white),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
//           Custom App bar
            Stack(
              children: <Widget>[
                Positioned(
                  top: 20,
                  right: 20,
                  child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                          onTap: () {
                            _key.currentState.openEndDrawer();
                          },
                          child: Icon(Icons.menu))),
                ),
                Positioned(
                  top: 20,
                  right: 60,
                  child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                          onTap: (){
                            changeScreen(context, CartScreen());
                          },
                          child: Icon(Icons.shopping_cart))),
                ),
                Positioned(
                  top: 20,
                  right: 100,
                  child: Align(
                      alignment: Alignment.topRight, child: GestureDetector(
                      onTap: (){
                        _key.currentState.showSnackBar(SnackBar(
                            content: Text("User profile")));
                      },
                      child: Icon(Icons.person))),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:12 , bottom :15.0, left : 10),
                  child: Text(
                    'Gamers Multiverse',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),

//          Search Text field
//            Search(),

            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              // child: Padding(
              //   padding: const EdgeInsets.only(
              //       top: 8, left: 8, right: 8, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    title: TextField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      textInputAction: TextInputAction.search,
                      onSubmitted: (pattern)async{
                        await productProvider.search(productName: pattern);
                        changeScreen(context, ProductSearchScreen());
                      },
                      decoration: InputDecoration(
                        hintText: "Processors, Keyboards ...",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                        ),

                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
          //  ),

//            featured products
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: new Text('Featured products',
                      style: TextStyle(
                        fontSize: 16
                      ),)
                  ),
                ),
              ],
            ),
            FeaturedProducts(),

//          recent products
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: new Text('Recent products',style: TextStyle(
                          fontSize: 16
                      ),)),
                ),
              ],
            ),

            Column(
              children: productProvider.products
                  .map((item) => GestureDetector(
                child: ProductCard(
                  product: item,
                ),
              ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
