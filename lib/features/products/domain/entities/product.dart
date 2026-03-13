import 'package:flux_pos/features/auth/domain/entities/user.dart';

class Product {
  String id;
  String barcode;
  String name;
  int scans;
  String imageUrl;
  int stock;
  String category;
  String productTypeId;
  User? user;

  Product({
    required this.id,
    required this.barcode,
    required this.name,
    required this.scans,
    required this.imageUrl,
    required this.stock,
    required this.category,
    required this.productTypeId,
     this.user,
  });

}



