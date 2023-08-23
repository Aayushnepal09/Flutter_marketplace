import 'dart:io';

import 'package:KinBech/app/network_connectivity.dart';
import 'package:KinBech/data_source/local_data_source/product_data_source.dart';
import 'package:KinBech/model/products.dart';

import '../data_source/remote_data_source/product_remote_data_source.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<List<Product>?> getProductsByCategory(String categoryId);
  Future<int> addProduct(File? file, Product Product);
}

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<int> addProduct(File? file, Product product) async {
    return ProductRemoteDataSource().addProdct(file, product);
  }

  @override
  Future<List<Product>> getProducts() async {
    bool status = await NetworkConnectivity.isOnline();
    List<Product> lstProduct = [];
    if (status) {
      lstProduct = await ProductRemoteDataSource().getAllProduct();
      await ProductDataSource().addAllProduct(lstProduct);
      return lstProduct;
    } else {
      return ProductDataSource().getProducts();
    }
  }

  @override
  Future<List<Product>?> getProductsByCategory(String categoryId) async {
    bool status = await NetworkConnectivity.isOnline();
    if (status) {
      return ProductRemoteDataSource().getProductsByCategory(categoryId);
    } else {
      return [];
    }
  }
}
