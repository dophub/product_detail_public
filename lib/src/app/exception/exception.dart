/// Written for Http Exception error
class ProductDetailValidationException implements Exception {
  final dynamic type;
  final int index;

  ProductDetailValidationException({
    required this.type,
    required this.index,
  });
}
