import 'package:flutter/material.dart';
import '../models/product.dart';
import '../localization/app_localizations.dart';
import '../main.dart'; // for MyApp.setLocale

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentLang = 'en';

  // In-page cart storage (no extra files/providers)
  final List<Map<String, dynamic>> _cart = [];

  // Theme helpers (blue / beige / white / black)
  final Color _blue = Colors.blueAccent;
  final Color _beige = const Color(0xFFF5EFE6);
  final Color _cardBg = Colors.white;
  final Color _textDark = Colors.black87;

  void _toggleLanguage() {
    setState(() {
      currentLang = currentLang == 'en' ? 'ar' : 'en';
    });
    MyApp.setLocale(context, Locale(currentLang));
  }

  void _addToCart(Product p, AppLocalizations loc) {
    _cart.add({
      'titleKey': p.titleKey,
      'imageUrl': p.imageUrl,
      'price': p.price,
    });
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(loc.addedToCart),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showCartDialog(AppLocalizations loc) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          loc.translate('cart') == 'cart' ? 'Cart' : loc.translate('cart'),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: _cart.isEmpty
              ? Text(
                  loc.translate('cart_empty') == 'cart_empty'
                      ? (currentLang == 'ar'
                            ? 'السلة فارغة'
                            : 'Your cart is empty')
                      : loc.translate('cart_empty'),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: _cart.length,
                  itemBuilder: (context, index) {
                    final item = _cart[index];
                    return ListTile(
                      dense: true,
                      leading: Image.asset(
                        item['imageUrl'],
                        width: 46,
                        height: 46,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        loc.translate(item['titleKey']),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Text(
                        _money(item['price'] as double),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(currentLang == 'ar' ? 'إغلاق' : 'Close'),
          ),
        ],
      ),
    );
  }

  // Discounts for offers (newPrice = item.price; oldPrice is computed)
  // shoes 25%, handbag 30%, earbuds 15%, smartwatch 20%; phonecases = BOGO (no strike)
  double? _discountForOffer(String titleKey) {
    switch (titleKey) {
      case 'offer_shoes':
        return 0.25;
      case 'offer_handbag':
        return 0.30;
      case 'offer_earbuds':
        return 0.15;
      case 'offer_smartwatch':
        return 0.20;
      default:
        return null; // offer_phonecases → special (no strikethrough)
    }
  }

  String _money(num v) => "\$${v.toStringAsFixed(2)}";

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: _beige,
      appBar: AppBar(
        backgroundColor: _blue,
        title: Text(
          loc.translate('app_title'), // shorter & always fits
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          // Cart badge
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () => _showCartDialog(loc),
              ),
              if (_cart.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      _cart.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          TextButton(
            onPressed: _toggleLanguage,
            child: Text(
              currentLang == 'en' ? loc.languageArabic : loc.languageEnglish,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Featured =====
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                loc.featured,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _textDark,
                ),
              ),
            ),
            SizedBox(
              height: 220,
              child: PageView.builder(
                itemCount: featured.length, // order: headphones, laptop, iphone
                controller: PageController(viewportFraction: 0.85),
                itemBuilder: (context, index) {
                  final item = featured[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      color: _cardBg,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              item.imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          // name chip
                          Positioned(
                            top: 10,
                            left: 10,
                            child: _pill(
                              child: Text(
                                loc.translate(item.titleKey),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          // price chip
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: _pill(
                              child: Text(
                                _money(item.price),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // ===== Products Grid =====
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(
                loc.ourProducts,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _textDark,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: products
                    .length, // order: tshirt, trousers, sunglasses, backpack
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final item = products[index];
                  return Card(
                    color: _cardBg,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                child: Image.asset(
                                  item.imageUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                              // price on photo
                              Positioned(
                                bottom: 6,
                                right: 6,
                                child: _pill(
                                  child: Text(
                                    _money(item.price),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6.0,
                            horizontal: 6,
                          ),
                          child: Text(
                            loc.translate(item.titleKey),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: _textDark,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // small add button (themed)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ElevatedButton.icon(
                            onPressed: () => _addToCart(item, loc),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _blue,
                              minimumSize: const Size(110, 32),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            icon: const Icon(
                              Icons.add_shopping_cart,
                              size: 16,
                              color: Colors.white,
                            ),
                            label: Text(
                              loc.addToCart,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // ===== Hot Offers =====
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(
                loc.hotOffers,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _textDark,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: offers.map((item) {
                  final discount = _discountForOffer(item.titleKey);
                  final double newPrice =
                      item.price; // your list holds the discounted price
                  final double? oldPrice =
                      (discount != null && discount > 0 && discount < 1)
                      ? (newPrice / (1 - discount))
                      : null;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Stack(
                      children: [
                        Card(
                          color: _cardBg,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  item.imageUrl,
                                  fit: BoxFit.cover,
                                  height: 180,
                                  width: double.infinity,
                                ),
                              ),
                              // offer title chip (one clean title — no duplicates)
                              Positioned(
                                top: 8,
                                left: 8,
                                child: _pill(
                                  child: Text(
                                    loc.translate(item.titleKey),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              // prices area (old crossed + new) using theme colors, always readable
                              Positioned(
                                bottom: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.92),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black12),
                                  ),
                                  child: Row(
                                    children: [
                                      if (oldPrice != null)
                                        Text(
                                          _money(oldPrice),
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 13,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationThickness:
                                                1, // subtle line so price still readable
                                          ),
                                        ),
                                      if (oldPrice != null)
                                        const SizedBox(width: 8),
                                      Text(
                                        _money(newPrice),
                                        style: TextStyle(
                                          color: _blue,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // small themed add-to-cart in the image corner
                        Positioned(
                          bottom: 12,
                          right: 12,
                          child: ElevatedButton.icon(
                            onPressed: () => _addToCart(item, loc),
                            icon: const Icon(
                              Icons.add_shopping_cart,
                              size: 16,
                              color: Colors.white,
                            ),
                            label: Text(
                              loc.addToCart,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _blue,
                              minimumSize: const Size(110, 32),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // small white rounded chip used for labels/prices on images
  Widget _pill({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      child: child,
    );
  }
}
