import 'package:flutter/material.dart';
import 'package:prmproject/bottom_bar.dart';
import 'package:prmproject/screens/const/theme_data.dart';
import 'package:prmproject/screens/inner_screens/brands_navigation_rail.dart';
import 'package:prmproject/screens/inner_screens/categories_feeds.dart';
import 'package:prmproject/screens/inner_screens/product_details.dart';
import 'package:prmproject/screens/models/products.dart';
import 'package:prmproject/screens/provider/cart_provider.dart';
import 'package:prmproject/screens/provider/dark_theme.dart';
import 'package:prmproject/screens/provider/favs_provider.dart';
import 'package:prmproject/widget/wishlist.dart';
import 'package:provider/provider.dart';

import 'screens/auth/login.dart';
import 'screens/auth/sign_up.dart';

import 'screens/cart.dart';
import 'screens/feeds.dart';
import 'screens/landing_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) {
            return themeChangeProvider;
          }),
          ChangeNotifierProvider(
            create: (_) => Products(),
          ),
          ChangeNotifierProvider(
            create: (_) => CartProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => FavsProvider(),
          ),
        ],
        child:
            Consumer<DarkThemeProvider>(builder: (context, themeData, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            home: LandingPage(),
            //initialRoute: '/',
            routes: {
              //   '/': (ctx) => LandingPage(),
              BrandNavigationRailScreen.routeName: (ctx) =>
                  BrandNavigationRailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              Feeds.routeName: (ctx) => Feeds(),
              WishlistScreen.routeName: (ctx) => WishlistScreen(),
              ProductDetails.routeName: (ctx) => ProductDetails(),
              CategoriesFeedsScreen.routeName: (ctx) => CategoriesFeedsScreen(),
              LoginScreen.routeName: (ctx) => LoginScreen(),
              SignUpScreen.routeName: (ctx) => SignUpScreen(),
              BottomBarScreen.routeName: (ctx) => BottomBarScreen(),
            },
          );
        }));
  }
}
