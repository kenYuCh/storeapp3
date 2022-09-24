import 'package:flutter/material.dart';
import 'package:storeappver3/theme.dart';

class ProductSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
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
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: (() {
          query = '';
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
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // final list = Provider.of<TravelProvider>(context);

    return Container(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return const Text("data");
          }),
    );
  }
}
