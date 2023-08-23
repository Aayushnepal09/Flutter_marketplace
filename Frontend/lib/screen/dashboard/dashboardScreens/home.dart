import 'dart:async';

import 'package:KinBech/components/productcard.dart';
import 'package:KinBech/model/products.dart';
import 'package:KinBech/repository/product_repo.dart';
import 'package:KinBech/screen/dashboard/dashboardScreens/cart/slider.dart';
import 'package:KinBech/theme/size_config.dart';
import 'package:KinBech/theme/theme_data.dart';
import 'package:all_sensors2/all_sensors2.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _proximityValue = 0;
  final List<StreamSubscription<dynamic>> _streamSubscription = [];
  @override
  void initState() {
    _streamSubscription.add(proximityEvents!.listen((event) {
      setState(() {
        _proximityValue = event.proximity;
      });
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: const Text('KinBech'),
          backgroundColor: COLOR_PRIMARY,
        ),
        backgroundColor: COLOR_SECONDARY,
        body: SafeArea(
          child: Column(children: [
            CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 0.6,
                autoPlayAnimationDuration: const Duration(milliseconds: 150),
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: imagesList
                  .map(
                    (item) => Center(
                      child: Image.network(
                        item,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                  .toList(),
            ),
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
                        itemBuilder: (context, index) {
                          return ProductCard(
                            product: products[index],
                          );
                        });
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ]),
        ));
  }
}
