import 'package:flutter/material.dart';
import 'package:prmproject/bottom_bar.dart';
import 'package:prmproject/widget/upload_product_form.dart';

class MainScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [BottomBarScreen(), UploadProductForm()],
    );
  }
}
