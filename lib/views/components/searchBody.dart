import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeappver3/components/constants.dart';
import 'package:storeappver3/controll/product.dart';
import 'package:storeappver3/models/product.dart';
import 'package:storeappver3/theme.dart';
import 'package:storeappver3/views/productDetail.dart';

class ProductSearchDelegate extends SearchDelegate {
  List<ProductModel> searchResults = [];
  String categoryItem = "";
  @override
  ThemeData appBarTheme(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    searchResults = productProvider.productItems;
    categoryItem = productProvider.dropdownItem;

    return ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0.0,
        ),
        textTheme: const TextTheme(
          // Use this to change the query's text style
          headline6: TextStyle(fontSize: 15.0, color: Colors.white),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: textWhite),
          focusColor: textWhite,
          border: InputBorder.none,
        ));
  }

  @override
  ProductSearchDelegate()
      : super(
          textInputAction: TextInputAction.search,
          searchFieldDecorationTheme: InputDecorationTheme(),
        );

  @override
  PreferredSizeWidget? buildBottom(BuildContext context) {
    final dropdownItem = Provider.of<ProductProvider>(context, listen: true);
    final category = categoryList;
    return PreferredSize(
      preferredSize: Size.fromHeight(56.0),
      child: DropdownButton(
        dropdownColor: Colors.black,
        value: dropdownItem.dropdownItem,
        items: category
            .map((value) => DropdownMenuItem(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(color: Colors.white),
                )))
            .toList(),
        onChanged: (value) {
          dropdownItem.setDropdownItem(value);
        },
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    print("buildActions");
    return [
      IconButton(
        onPressed: (() {
          if (query.isEmpty) {
            // close(context, null); // close search bar
          } else {
            query = '';
          }
        }),
        icon: const Icon(
          Icons.clear,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: (() => close(context, null)),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
    // List<ProductModel> suggestions = searchResults.where((searchResult) {
    //   final result = searchResult.title.toLowerCase();
    //   final input = query.toLowerCase();
    //   return result.contains(input);
    // }).toList();

    // return Container(
    //   padding: const EdgeInsets.all(10.0),
    //   child: ListView.builder(
    //       itemCount: suggestions.length,
    //       itemBuilder: (context, index) {
    //         final suggestion = suggestions[index];
    //         return ListTile(
    //           onTap: () {
    //             query = suggestion as String;
    //           },
    //           leading: Image.network(
    //             "${suggestions[index].image}",
    //             width: 60.0,
    //           ),
    //           title: Text("${suggestions[index].title}"),
    //           subtitle: Text("${suggestions[index].category}"),
    //           trailing: Text("${suggestions[index].price.toInt()} \$ "),
    //         );
    //       }),
    // );
  }

  /*
  ????????????????????????????????????????????????????????????????????????????????????
  ?????? [query] ??????????????????????????????????????????????????? ???????????????????????? [query] ???????????? 
  ???????????????????????????????????????????????????????????????????????????????????????????????????
  */
  @override
  Widget buildSuggestions(BuildContext context) {
    List<ProductModel> suggestions = searchResults.where((searchResult) {
      final result = searchResult.title.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);

      // if (categoryItem.isNotEmpty) {
      //   final result = searchResult.category.toLowerCase();
      //   final input = categoryItem.toLowerCase();
      //   return result.contains(input);
      // } else {
      //   final result = searchResult.title.toLowerCase();
      //   final input = query.toLowerCase();
      //   return result.contains(input);
      // }
    }).toList();

    return Container(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final suggestion = suggestions[index];
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) {
                      return ProductDetail(product: suggestion);
                    }),
                  ),
                );
              },
              leading: Image.network(
                "${suggestions[index].image}",
                width: 60.0,
              ),
              title: Text("${suggestions[index].title}"),
              subtitle: Text("${suggestions[index].category}"),
              trailing: Text("${suggestions[index].price.toInt()} \$ "),
            );
          }),
    );
  }
}
