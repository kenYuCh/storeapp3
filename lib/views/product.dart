import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeappver3/controll/product.dart';
import 'package:storeappver3/models/product.dart';
import 'package:storeappver3/theme.dart';
import 'package:storeappver3/views/components/searchBody.dart';
import 'package:storeappver3/views/productCard.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 60.0,
        titleSpacing: 0.0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_basket),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: ScrollViewBody(),
    );
  }
}

class ScrollViewBody extends StatefulWidget {
  const ScrollViewBody({super.key});

  @override
  State<ScrollViewBody> createState() => _ScrollViewBodyState();
}

class _ScrollViewBodyState extends State<ScrollViewBody> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final catagoryType =
        Provider.of<ProductProvider>(context, listen: false).catagoryType;
    final size = MediaQuery.of(context).size;
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        // AppTitle
        SliverToBoxAdapter(
          child: Stack(
            children: [
              Container(
                child: Image.asset(
                  "assets/images/titleBg.png",
                  height: 200.0,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 0,
                top: 65,
                child: Image.asset(
                  "assets/images/girl.png",
                  width: 150.0,
                  height: 100.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, bottom: 10.0, top: 45.0),
                child: ListTile(
                  // contentPadding: EdgeInsets.all(20.0),
                  title: Text(
                    "SHOP",
                    style: shopHeader,
                  ),
                  subtitle: Text(
                    "Welcom to my SHOP ",
                    style: subHeaderTitle,
                  ),
                ),
              ),
            ],
          ),
        ),
        // SeacrhBar
        SliverAppBar(
          floating: true,
          pinned: false,
          backgroundColor: Colors.black,
          expandedHeight: 60.0,
          stretch: true,
          excludeHeaderSemantics: false,
          title: Container(
            alignment: Alignment.center,
            height: 40,
            decoration: BoxDecoration(
              color:
                  const Color.fromARGB(78, 82, 82, 82), // Box-BackgroundColor
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextField(
              onTap: (() {
                showSearch(context: context, delegate: ProductSearchDelegate());
              }),
              controller: _textEditController,
              readOnly: true,
              style: const TextStyle(color: Colors.white), // font color
              cursorColor: Colors.white,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search, color: iconsWhite)),
                suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.qr_code, color: iconsWhite)),
                fillColor: Colors.white,
                hintText: "Search",
                hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.5), fontSize: 20.0),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ),
        // CategoryLabel
        SliverToBoxAdapter(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 40.0,
                  width: size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        Provider.of<ProductProvider>(context, listen: true)
                            .catagoryType
                            .length,
                    itemBuilder: ((context, index) {
                      return Center(
                        child: CatagoryType(
                          catagory: catagoryType[index][0],
                          isSelected: catagoryType[index][1],
                          onTap: () => productProvider.selectedCatagory(index),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              height: size.height * 0.55,
              child: Consumer<ProductProvider>(
                builder: (context, data, child) {
                  return data.productList.isNotEmpty == true
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return ProductCard(
                              product: ProductModel.fromJson(
                                  data.productList[index].toJson()),
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            "Loading...",
                            style: TextStyle(color: textWhite),
                          ),
                        );
                },
              )),
        ),
      ],
    );
  }
}

class CatagoryType extends StatelessWidget {
  const CatagoryType({
    super.key,
    required this.catagory,
    required this.isSelected,
    required this.onTap,
  });
  final String catagory;
  final bool isSelected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Container(
          height: 30.0,
          child: Text(
            catagory,
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white70 : Colors.white38),
          ),
        ),
      ),
    );
  }
}
