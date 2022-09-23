import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storeappver3/theme.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
    required this.rating,
  });
  final String title;
  final int price;
  final String description;
  final String category;
  final String images;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Container(
        padding: EdgeInsets.all(10.0),
        width: 250,
        decoration: BoxDecoration(
          color: Color.fromARGB(58, 82, 82, 82),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              "${images}",
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
                "${category}",
                style: GoogleFonts.adamina(fontSize: 20.0, color: textWhite),
              ),
              subtitle: Text(
                "${title}",
                style: GoogleFonts.bebasNeue(fontSize: 15.0, color: textWhite),
              ),
              trailing: Text(
                "${price} \$",
                style: GoogleFonts.bebasNeue(fontSize: 20.0, color: textWhite),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rating: 3.75",
                    style:
                        GoogleFonts.bebasNeue(fontSize: 20.0, color: textWhite),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: (() {}),
                        icon: Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "0",
                        style: TextStyle(color: Colors.white),
                      ),
                      IconButton(
                        onPressed: (() {}),
                        icon: Icon(
                          Icons.add,
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
    );
  }
}
