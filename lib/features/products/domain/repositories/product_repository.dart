
import 'package:flux_pos/features/products/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProductByPage({int limit = 10, int offset = 0});
  Future<Product> getProductById(String id);
  Future<List<Product>> searchProductsByTerm(String term);
  Future<Product> createUpdateProducts(Map<String, dynamic> productLike);
}