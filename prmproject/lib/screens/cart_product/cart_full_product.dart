import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:prmproject/screens/inner_screens/product_details.dart';
import 'package:prmproject/screens/models/cart_product_attr.dart';
import 'package:prmproject/screens/models/orders_attr.dart';
import 'package:prmproject/screens/provider/cart_provider.dart';
import 'package:prmproject/screens/provider/dark_theme.dart';
import 'package:prmproject/screens/services/global_method.dart';
import 'package:provider/provider.dart';

class CartProductFull extends StatefulWidget {
  @override
  _OrderFullState createState() => _OrderFullState();
}

class _OrderFullState extends State<CartProductFull> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final cartProductAttrProvider = Provider.of<CartProductAttr>(context);

    return InkWell(
      onTap: () => Navigator.pushNamed(context, ProductDetails.routeName,
          arguments: cartProductAttrProvider.productId),
      child: Container(
        height: 150,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: const Radius.circular(16.0),
            topRight: const Radius.circular(16.0),
          ),
          color: Theme.of(context).backgroundColor,
        ),
        child: Row(
          children: [
            Container(
              width: 130,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(cartProductAttrProvider.productImage),
                  //  fit: BoxFit.fill,
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            cartProductAttrProvider.productTitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(32.0),
                            // splashColor: ,
                            onTap: () {
                              globalMethods.showDialogg(
                                  'Remove order!', 'Product will be deleted!',
                                  () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                await FirebaseFirestore.instance
                                    .collection('products')
                                    .doc(cartProductAttrProvider.productId)
                                    .delete();
                              }, context);
                              //
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              child: _isLoading
                                  ? CircularProgressIndicator()
                                  : Icon(
                                      Entypo.cross,
                                      color: Colors.red,
                                      size: 22,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Price:'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${cartProductAttrProvider.price}\$',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Quantity:'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'x${cartProductAttrProvider.productQuantity}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(child: Text('Order ID:')),
                        SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Text(
                            'x${cartProductAttrProvider.productId}',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
