import 'package:KinBech/app/constants.dart';
import 'package:KinBech/components/toproundedcontainer.dart';
import 'package:KinBech/model/products.dart';
import 'package:KinBech/theme/size_config.dart';
import 'package:KinBech/theme/theme_data.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: getProportionateScreenWidth(400),
            child: AspectRatio(
              aspectRatio: 2,
              child: Image.network(
                Constant.productImageURL + product.image!,
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(38),
                width: getProportionateScreenWidth(48),
              )
            ],
          ),
          Container(
            color: COLOR_PRIMARY,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(166),
                      vertical: getProportionateScreenHeight(25)),
                  child: Text(product.name!,
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                  ),
                  child: Text(
                    "Description: ${product.description}",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Text(
                    "Price: ${product.price}",
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(40),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: getProportionateScreenHeight(100)),
                  padding:
                      EdgeInsets.only(top: getProportionateScreenHeight(130)),

                  // width: double.infinity,

                  child: ToproundedContainer(
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(50, 0, 70, 20),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              backgroundColor: COLOR_PRIMARY,
                              minimumSize: const Size.fromHeight(60)),
                          child: const Text(
                            "ADD TO Watchlist",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 11, 10, 10)),
                          ),
                          onPressed: () {},
                        ),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
