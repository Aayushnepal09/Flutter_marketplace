import 'package:KinBech/screen/dashboard/dashboardScreens/cart/cartbody.dart';
import 'package:KinBech/theme/size_config.dart';
import 'package:KinBech/theme/theme_data.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Column(children: const [
        Text('Wishlist'),
        Text(
          "2 items",
          style: TextStyle(color: Colors.blue, fontSize: 20),
        )
      ])),
      body: CartBody(),
      bottomNavigationBar: CheckoutCard(),
    );
  }
}

class CheckoutCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(15),
          horizontal: getProportionateScreenWidth(30)),
      decoration: const BoxDecoration(
        color: COLOR_WHITE,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0), topRight: Radius.circular(200)),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, -20),
              blurRadius: 20,
              color: Color.fromARGB(255, 8, 0, 0)),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Row(
            //   children: [
            //     Container(
            //       padding: const EdgeInsets.all(10),
            //       height: getProportionateScreenHeight(50),
            //       width: getProportionateScreenWidth(50),
            //       decoration: BoxDecoration(
            //           color: const Color.fromARGB(255, 13, 9, 9),
            //           borderRadius: BorderRadius.circular(10)),
            //       child: const Icon(
            //         Icons.library_add_check_rounded,
            //         color: Colors.white,
            //         size: 30,
            //       ),
            //     )
            //   ],
            // ),
            // SizedBox(
            //   height: getProportionateScreenHeight(20),
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     const Text.rich(TextSpan(text: ('Total '), children: [
            //       TextSpan(
            //           text: ("Rs 500"),
            //           style: TextStyle(fontSize: 30, color: Colors.red))
            //     ])),
            //     SizedBox(
            //       width: getProportionateScreenWidth(180),
            //       child: ElevatedButton(
            //           onPressed: () {}, child: const Text("Delete all")),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
