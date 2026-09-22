class ProductModel {
  final String id;
  final String name;
  final String category;
  final String description;
  final double price;
  final String unit;
  final String imageUrl;
  final int moq;
  final double rating;
  final int reviewCount;
  final String seller;
  final bool isVerifiedSeller;
  final int gsm;
  final String materialComposition;
  final String width;
  final String pattern;
  final String finish;
  final String color;
  final List<String> availableColors;
  final List<String> availableSizes;
  final int availableStock;
  final bool inStock;
  final bool isFeatured;
  final bool isPopular;
  final bool isNewArrival;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.unit,
    required this.imageUrl,
    required this.moq,
    this.rating = 4.5,
    this.reviewCount = 120,
    this.seller = 'Generic Textiles Ltd.',
    this.isVerifiedSeller = true,
    this.gsm = 120,
    this.materialComposition = '100% Cotton',
    this.width = '44 inches',
    this.pattern = 'Solid',
    this.finish = 'Soft',
    this.color = 'Multi',
    this.availableColors = const ['White', 'Black', 'Blue', 'Red'],
    this.availableSizes = const ['44 inches', '58 inches'],
    this.availableStock = 5000,
    this.inStock = true,
    this.isFeatured = false,
    this.isPopular = false,
    this.isNewArrival = false,
  });
}

class CategoryModel {
  final String id;
  final String name;
  final String imageUrl;
  final int productCount;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.productCount,
  });
}
