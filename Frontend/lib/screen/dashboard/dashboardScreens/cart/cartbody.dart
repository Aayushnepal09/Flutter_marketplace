import 'package:KinBech/components/productcard.dart';
import 'package:KinBech/model/products.dart';
import 'package:KinBech/repository/product_repo.dart';
import 'package:KinBech/theme/theme_data.dart';
import 'package:flutter/material.dart';

class CartBody extends StatefulWidget {
  const CartBody({super.key});

  @override
  _CartBodyState createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('KinBech'),
        //   backgroundColor: COLOR_PRIMARY,
        // ),
        backgroundColor: COLOR_SECONDARY,
        body: SafeArea(
          child: Column(children: [
            // CarouselSlider(
            //   options: CarouselOptions(
            //     //viewportFraction: 0.6,
            //     autoPlayAnimationDuration: const Duration(milliseconds: 150),
            //     autoPlay: true,
            //     enlargeCenterPage: true,
            //   ),
            //   items: imagesList
            //       .map(
            //         (item) => Center(
            //           child: Image.network(
            //             item,
            //             fit: BoxFit.cover,
            //           ),
            //         ),
            //       )
            //       .toList(),
            // ),
            Expanded(
                child: FutureBuilder(
                    future: ProductRepositoryImpl().getProducts(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final products = snapshot.data as List<Product>;
                        return GridView.builder(
                            shrinkWrap: true,
                            itemCount: products.length,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.8,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 24),
                            itemBuilder: (context, cart) {
                              return ProductCard(
                                product: products[cart],
                              );
                            });
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }))
          ]),
        ));
  }
}
