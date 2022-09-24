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

    final itemsA = Provider.of<CartProvider>(context, listen: true).itemsA;
    final cart = Provider.of<CartProvider>(context, listen: false);

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
              itemCount: itemsA.length,
              itemBuilder: ((context, index) {
                return Container(
                  height: 140.0,
                  alignment: Alignment.center,
                  child: ListTile(
                    leading: Image.network(
                      // "${cartItems[index]['product']['image']}",
                      "${itemsA.values.toList()[index].image}",
                      height: 50.0,
                      width: 50.0,
                    ),
                    title: Column(children: [
                      Text("${itemsA.values.toList()[index].title}"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("${itemsA.values.toList()[index].price} \$"),
                          Row(
                            children: [
                              IconButton(
                                onPressed: (() {
                                  // cartProvider.decreaseA();
                                  cart.decrease();
                                }),
                                icon: Icon(Icons.remove),
                              ),
                              Text("${itemsA.values.toList()[index].quantity}"),
                              IconButton(
                                onPressed: (() {
                                  cart.increase();
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
                          cart.removeItem(itemsA.values.toList()[index].id);
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
                  child: Text("Total Price: ${cart.totalAmount}"),
                ),
              )),
        ],
      ),
    );
  }
}
