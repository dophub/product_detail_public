import 'package:flutter/cupertino.dart';

/// Written for Http Exception error
class ProductDetailValidationException implements Exception {
  final GlobalKey key;

  ProductDetailValidationException({
    required this.key,
  });
}
