import 'package:KinBech/model/cart.dart';
import 'package:KinBech/theme/size_config.dart';
import 'package:KinBech/theme/theme_data.dart';
import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(
        width: getProportionateScreenWidth(80),
        child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 202, 203, 214),
                  borderRadius: BorderRadius.circular(15)),
              child: Image.asset(cart.product.image!),
            )),
      ),
      SizedBox(
        width: getProportionateScreenWidth(20),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cart.product.name!,
            maxLines: 2,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          const SizedBox(
            height: 10,
          ),
          Text.rich(TextSpan(
              text: cart.product.price!,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: COLOR_PRIMARY)))
        ],
      )
    ]);
  }
}
