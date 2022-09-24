import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:storeappver3/controll/cart.dart';
import 'package:storeappver3/controll/product.dart';

class CartList extends StatelessWidget {
  const CartList({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final cartItems =
        Provider.of<CartProvider>(context, listen: true).cartItems;
    final totalPrice =
        Provider.of<CartProvider>(context, listen: true).totalPrice;
    // print(cartItems[0]['product']['id']);
    return Container(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(15.0),
            decoration: const BoxDecoration(
                // color: Colors.amber,
                // borderRadius: BorderRadius.circular(25),
                ),
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: ((context, index) {
                return Container(
                  height: 140.0,
                  alignment: Alignment.center,
                  child: ListTile(
                    leading: Image.network(
                      "${cartItems[index]['product']['image']}",
                      height: 50.0,
                      width: 50.0,
                    ),
                    title: Column(children: [
                      Text("${cartItems[index]['product']['title']}"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                              "${cartItems[index]['product']['price'].toInt()} \$"),
                          Row(
                            children: [
                              IconButton(
                                onPressed: (() {
                                  cartProvider.decrease();
                                }),
                                icon: Icon(Icons.remove),
                              ),
                              Text("${cartItems[index]['number']}"),
                              IconButton(
                                onPressed: (() {
                                  cartProvider.increase();
                                }),
                                icon: Icon(Icons.add),
                              ),
                            ],
                          )
                        ],
                      ),
                    ]),
                    trailing: IconButton(
                        onPressed: (() {
                          cartProvider.removeProduct(
                              cartItems[index]['cartID'],
                              cartItems[index]['product']['id'],
                              cartItems[index]['itemTotalPrice']);
                        }),
                        icon: Icon(Icons.delete)),
                  ),
                );
              }),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                height: 60.0,
                width: size.width,
                decoration: BoxDecoration(color: Colors.grey),
                child: Center(
                  child: Text("Total Price: ${totalPrice}"),
                ),
              )),
        ],
      ),
    );
  }
}
