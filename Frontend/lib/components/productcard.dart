import 'package:KinBech/app/constants.dart';
import 'package:KinBech/model/products.dart';
import 'package:KinBech/screen/dashboard/productDetail/productdetails.dart';
import 'package:KinBech/theme/size_config.dart';
import 'package:KinBech/theme/theme_data.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, "/productdetail",
            arguments: ProductDetailsArguments(product: product));
      },
      child: Card(
        elevation: 5.0,
        child: InkWell(
          child: SizedBox(
            width: getProportionateScreenWidth(140),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                AspectRatio(
                  aspectRatio: 1.02,
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                    decoration: BoxDecoration(
                      color: COLOR_GREY.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.network(
                      Constant.userImageURL + product.image!,
                    ),
                  ),
                ),
                Text(product.name!),
                Text(product.price!)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
