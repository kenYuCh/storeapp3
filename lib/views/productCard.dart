import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storeappver3/models/product.dart';
import 'package:storeappver3/theme.dart';
import 'package:storeappver3/views/productDetail.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: GestureDetector(
        onTap: (() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) {
                return ProductDetail(product: product);
              }),
            ),
          );
        }),
        child: Container(
          padding: EdgeInsets.all(10.0),
          width: 280,
          // height: 400,
          decoration: BoxDecoration(
            color: Color.fromARGB(58, 82, 82, 82),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                "${product.image}",
                height: 210.0,
                width: 200.0,
                fit: BoxFit.contain,
                scale: 1.0,
              ),
              SizedBox(
                height: 5.0,
              ),
              ListTile(
                dense: true,
                title: Text(
                  "${product.category}",
                  style: GoogleFonts.adamina(fontSize: 20.0, color: textWhite),
                ),
                subtitle: Text(
                  "${product.title}",
                  style:
                      GoogleFonts.bebasNeue(fontSize: 15.0, color: textWhite),
                ),
                trailing: Text(
                  "${product.price} \$",
                  style:
                      GoogleFonts.bebasNeue(fontSize: 20.0, color: textWhite),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${product.rating}",
                      style: GoogleFonts.bebasNeue(
                          fontSize: 20.0, color: textWhite),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: (() {}),
                          icon: Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
