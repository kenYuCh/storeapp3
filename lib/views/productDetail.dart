import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeappver3/controll/cart.dart';
import 'package:storeappver3/controll/product.dart';
import 'package:storeappver3/memory/product.dart';

import 'package:storeappver3/models/product.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Provider.of<CartProvider>(context, listen: false).quantity = 0;
            Navigator.of(context).pop();
          },
        ),
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(context) {
    final size = MediaQuery.of(context).size;
    // final removeImage = ProductMemo().removeBackground();
    Rating? rating = product.rating;

    return Container(
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            height: size.height,
          ),
          Positioned(
            top: 20,
            right: 30,
            child: Container(
              height: size.height * 0.55,
              decoration: const BoxDecoration(color: Colors.white),
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                child: Image.network(
                  "${product.image}",
                  height: size.height * 0.30,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: size.height * 0.50,
              width: size.width,
              decoration: const BoxDecoration(
                color: Color.fromARGB(108, 203, 197, 197),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 150, left: 40, right: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: const Text(
                        "Description",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      child: Text("${product.description}"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 70,
            left: 20,
            child: SizedBox(
              height: 70.0,
              width: size.width,
              child: ListTile(
                title: Text("${product.title}"),
                subtitle: Text("${product.category}"),
              ),
            ),
          ),
          Positioned(
            top: 200,
            left: 20,
            child: SizedBox(
              height: 70.0,
              width: size.width,
              child: ListTile(
                title: Text("${product.price.toInt()} TWD\$"),
                subtitle: Text("count: ${rating!.count.toInt()}"),
              ),
            ),
          ),
          Positioned(
            top: 410,
            left: 100,
            child: Container(
              width: size.width / 2,
              height: 40.0,
              decoration: const BoxDecoration(
                color: Color.fromARGB(166, 112, 131, 113),
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              ),
              child: Consumer<CartProvider>(
                builder: (context, provider, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: (() {
                          provider.switchAddRemove("decrease");
                        }),
                        icon: const Icon(Icons.remove),
                      ),
                      Text("${provider.quantity}"),
                      IconButton(
                        onPressed: (() {
                          provider.switchAddRemove("increase");
                        }),
                        icon: const Icon(Icons.add),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
          Positioned(top: 480, left: 150, child: buildBuy(size)),
        ],
      ),
    );
  }

  Widget buildBuy(size) {
    return Consumer<CartProvider>(builder: ((context, provider, child) {
      return GestureDetector(
        onTap: () {
          provider.addItem(product.id.toString(), product.price, product.title,
              product.image);
        },
        child: Container(
            width: size.width / 4,
            height: 40.0,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color.fromARGB(166, 112, 131, 113),
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
            ),
            child: Text("Buy")),
      );
    }));
  }
}
