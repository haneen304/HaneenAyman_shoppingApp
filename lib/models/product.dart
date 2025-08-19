class Product {
  final String id;
  final String titleKey; // key for localization
  final String imageUrl;
  final double price;

  Product({
    required this.id,
    required this.titleKey,
    required this.imageUrl,
    required this.price,
  });
}

// Featured products
List<Product> featured = [
  Product(
    id: 'featured1',
    titleKey: 'featured_headphones',
    imageUrl: 'assets/images/featured1.jpg',
    price: 199.99,
  ),
  Product(
    id: 'featured2',
    titleKey: 'featured_laptop',
    imageUrl: 'assets/images/featured2.jpg',
    price: 1299.99,
  ),
  Product(
    id: 'featured3',
    titleKey: 'featured_iphone',
    imageUrl: 'assets/images/featured3.jpg',
    price: 999.99,
  ),
];

// Grid products
List<Product> products = [
  Product(
    id: 'product1',
    titleKey: 'product_tshirt',
    imageUrl: 'assets/images/product1.jpg',
    price: 29.99,
  ),
  Product(
    id: 'product2',
    titleKey: 'product_trousers',
    imageUrl: 'assets/images/product2.jpg',
    price: 49.99,
  ),
  Product(
    id: 'product3',
    titleKey: 'product_sunglasses',
    imageUrl: 'assets/images/product3.jpg',
    price: 79.99,
  ),
  Product(
    id: 'product4',
    titleKey: 'product_backpack',
    imageUrl: 'assets/images/product4.jpg',
    price: 59.99,
  ),
];

// Hot Offers
List<Product> offers = [
  Product(
    id: 'offer1',
    titleKey: 'offer_shoes',
    imageUrl: 'assets/images/offer1.jpg',
    price: 99.99,
  ),
  Product(
    id: 'offer2',
    titleKey: 'offer_handbag',
    imageUrl: 'assets/images/offer2.jpg',
    price: 79.99,
  ),
  Product(
    id: 'offer3',
    titleKey: 'offer_earbuds',
    imageUrl: 'assets/images/offer3.jpg',
    price: 49.99,
  ),
  Product(
    id: 'offer4',
    titleKey: 'offer_smartwatch',
    imageUrl: 'assets/images/offer4.jpg',
    price: 199.99,
  ),
  Product(
    id: 'offer5',
    titleKey: 'offer_phonecases',
    imageUrl: 'assets/images/offer5.jpg',
    price: 19.99,
  ),
];
