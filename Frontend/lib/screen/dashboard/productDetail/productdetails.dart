import 'package:KinBech/components/roundedbuttonicon.dart';
import 'package:KinBech/model/products.dart';
import 'package:KinBech/screen/dashboard/productDetail/body.dart';
import 'package:KinBech/theme/size_config.dart';
import 'package:KinBech/theme/theme_data.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments arguments =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(),
        body: Body(
          product: arguments.product,
        ));
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({super.key});
  List<int> selecteditem = [];
  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RoundedIconBtn(
              iconData: Icons.arrow_back_ios,
              press: () =>
                  Navigator.pushReplacementNamed(context, '/navigation'),
            ),
            IconButton(
              icon: const Icon(Icons.favorite_border),
              color: COLOR_PRIMARY,
              iconSize: 30,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailsArguments {
  final Product product;

  ProductDetailsArguments({required this.product});
}
