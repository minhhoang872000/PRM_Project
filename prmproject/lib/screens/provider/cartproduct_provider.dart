import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:prmproject/screens/models/cart_product_attr.dart';
import 'package:prmproject/screens/models/orders_attr.dart';

class CartProductProvider with ChangeNotifier {
  List<CartProductAttr> _cartproducts = [];
  List<CartProductAttr> get getOrders {
    return [..._cartproducts];
  }

  Future<void> fetchOrders() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User _user = _auth.currentUser;
    var _uid = _user.uid;
    print('the user Id is equal to $_uid');
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .where('userId', isEqualTo: _uid)
          .get()
          .then((QuerySnapshot cartProductSnapshot) {
        _cartproducts.clear();
        cartProductSnapshot.docs.forEach((element) {
          // print('element.get(productBrand), ${element.get('productBrand')}');
          _cartproducts.insert(
              0,
              CartProductAttr(
                productId: element.get('productId'),
                userId: element.get('userId'),
                productCategory: element.get('productCategory'),
                productTitle: element.get('productTitle'),
                price: element.get('price').toString(),
                productImage: element.get('productImage'),
                productQuantity: element.get('productQuantity').toString(),
                createAt: element.get('createdAt'),
                productBrand: element.get('productBrand'),
                productDescription: element.get('productDescription'),
              ));
        });
      });
    } catch (error) {
      print('Printing error wwhile fetching order $error');
    }
    notifyListeners();
  }
}
