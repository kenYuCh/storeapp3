import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeappver3/controll/product.dart';
import 'package:storeappver3/theme.dart';
import 'package:storeappver3/views/product.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
          child: ProductPage(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(),
        // splashColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.black, // scaffold
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
          titleTextStyle: TextStyle(),
          actionsIconTheme: IconThemeData(
            color: appBarIconsWhite,
          ),
          iconTheme: IconThemeData(
            color: appBarIconsWhite,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ProductPage(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int routeIndex = 0;
  void setIndex(int index) {
    setState(() {
      routeIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  final children = const <Widget>[
    ProductPage(),
    ProductPage(),
    ProductPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        backgroundColor: bottomBarColor,
        selectedItemColor: selectedItemColor,
        unselectedItemColor: unselectedItemColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: routeIndex,
        onTap: (int currentIndex) => setIndex(currentIndex),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              Icons.home_outlined,
            ),
            activeIcon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "traval",
            icon: Icon(Icons.travel_explore_sharp),
            activeIcon: Icon(Icons.travel_explore_sharp),
          ),
          BottomNavigationBarItem(
            label: "Favorite",
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
          ),
          // BottomNavigationBarItem(
          //   label: "Favorite",
          //   icon: Icon(Icons.favorite_border),
          //   activeIcon: Icon(Icons.favorite),
          // ),
        ],
      ),
    );
  }
}
