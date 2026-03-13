

import 'package:flux_pos/features/products/domain/datasources/product_datasource.dart';
import 'package:flux_pos/features/products/domain/entities/product.dart';

class ProductDatasourceImpl extends ProductsDatasource {
  @override
  Future<Product> createUpdateProducts(Map<String, dynamic> productLike) {
    throw UnimplementedError();
  }

  @override
  Future<Product> getProductById(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProductByPage({int limit = 10, int offset = 0}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> searchProductsByTerm(String term) {
    throw UnimplementedError();
  }

}