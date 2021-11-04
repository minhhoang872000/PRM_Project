import 'package:flutter/material.dart';
import 'package:prmproject/screens/cart_product/cart_full_product.dart';
import 'package:prmproject/screens/cart_product/cart_product_empty.dart';
import 'package:prmproject/screens/const/my_icons.dart';
import 'package:prmproject/screens/provider/cartproduct_provider.dart';
import 'package:prmproject/screens/provider/order_provider.dart';
import 'package:prmproject/screens/services/global_method.dart';
import 'package:prmproject/screens/services/payment.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class CartProductScreen extends StatefulWidget {
  //To be known 1) the amount must be an integer 2) the amount must not be double 3) the minimum amount should be less than 0.5 $
  static const routeName = '/CartProductScreen';

  @override
  _CartProductScreenState createState() => _CartProductScreenState();
}

class _CartProductScreenState extends State<CartProductScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StripeService.init();
  }

  void payWithCard({int amount}) async {
    ProgressDialog dialog = ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    var response = await StripeService.payWithNewCard(
        currency: 'USD', amount: amount.toString());
    await dialog.hide();
    print('response : ${response.message}');
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(response.message),
      duration: Duration(milliseconds: response.success == true ? 1200 : 3000),
    ));
  }

  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    final cartProductProvider = Provider.of<CartProductProvider>(context);
    // final cartProvider = Provider.of<CartProvider>(context);
    // print('orderProvider.getOrders length ${orderProvider.getOrders.length}');
    return FutureBuilder(
        future: cartProductProvider.fetchOrders(),
        builder: (context, snapshot) {
          return cartProductProvider.getOrders.isEmpty
              ? Scaffold(body: CartProductEmpty())
              : Scaffold(
                  appBar: AppBar(
                    backgroundColor: Theme.of(context).backgroundColor,
                    title: Text(
                        'Orders (${cartProductProvider.getOrders.length})'),
                    actions: [
                      IconButton(
                        onPressed: () {
                          // globalMethods.showDialogg(
                          //     'Clear cart!',
                          //     'Your cart will be cleared!',
                          //     () => cartProvider.clearCart(),
                          //     context);
                        },
                        icon: Icon(MyAppIcons.trash),
                      )
                    ],
                  ),
                  body: Container(
                    margin: EdgeInsets.only(bottom: 60),
                    child: ListView.builder(
                        itemCount: cartProductProvider.getOrders.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return ChangeNotifierProvider.value(
                              value: cartProductProvider.getOrders[index],
                              child: CartProductFull());
                        }),
                  ));
        });
  }
}
