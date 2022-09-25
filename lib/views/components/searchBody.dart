import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeappver3/controll/product.dart';
import 'package:storeappver3/models/product.dart';
import 'package:storeappver3/theme.dart';
import 'package:storeappver3/views/productDetail.dart';

class ProductSearchDelegate extends SearchDelegate {
  List<ProductModel> searchResults = [];
  @override
  ThemeData appBarTheme(BuildContext context) {
    searchResults =
        Provider.of<ProductProvider>(context, listen: false).productItems;
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
    return PreferredSize(
        preferredSize: Size.fromHeight(56.0), child: Container());
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
  當用戶在搜索字段中鍵入查詢時，搜索頁面正文中顯示的建議。
  只要 [query] 的內容髮生變化，就會調用委託方法。 建議應基於當前的 [query] 字符串。 
  如果查詢字符串為空，最好根據過去的查詢或當前上下文顯示建議的查詢。
  */
  @override
  Widget buildSuggestions(BuildContext context) {
    List<ProductModel> suggestions = searchResults.where((searchResult) {
      final result = searchResult.title.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
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
