import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CartProductAttr with ChangeNotifier {
  final String productId;
  final String userId;
  final String productCategory;
  final String productTitle;
  final String price;
  final String productImage;
  final String productQuantity;
  final Timestamp createAt;
  final String productBrand;
  final String productDescription;

  CartProductAttr(
      {this.productId,
      this.userId,
      this.productCategory,
      this.productTitle,
      this.price,
      this.productImage,
      this.productQuantity,
      this.createAt,
      this.productBrand,
      this.productDescription});
}
