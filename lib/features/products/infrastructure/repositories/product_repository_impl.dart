import 'package:flux_pos/features/products/domain/domain.dart';
import 'package:flux_pos/features/products/domain/entities/product.dart';
import 'package:flux_pos/features/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductsDatasource productsDatasource;

  ProductRepositoryImpl({required this.productsDatasource});

  @override
  Future<Product> createUpdateProducts(Map<String, dynamic> productLike) {
    return productsDatasource.createUpdateProducts(productLike);
  }

  @override
  Future<Product> getProductById(String id) {
    return productsDatasource.getProductById(id);
  }

  @override
  Future<List<Product>> getProductByPage({int limit = 10, int offset = 0}) {
    return productsDatasource.getProductByPage(limit: limit, offset: offset);
  }

  @override
  Future<List<Product>> searchProductsByTerm(String term) {
    return productsDatasource.searchProductsByTerm(term);
  }
}
