class ProductModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final String? photoUrl;
  final List<String> productPhotos;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.photoUrl,
    required this.productPhotos,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      photoUrl: json['photoUrl'],
      productPhotos: (json['productPhotos'] as List<dynamic>)
          .map((e) => e['url'] as String)
          .toList(),
    );
  }
}
