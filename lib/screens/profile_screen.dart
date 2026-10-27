import 'package:flutter/material.dart';

import '../app.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({
    super.key,
    required this.locale,
  });

  final Locale locale;

  @override
  Widget build(BuildContext context) {
    final isArabicLocale = isArabic(locale);

    return Scaffold(
      appBar: AppBar(title: Text(isArabicLocale ? 'المتجر' : 'Boutique')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFD71920),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  const Icon(Icons.stars, color: Color(0xFFC8A25C), size: 30),
                  const SizedBox(width: 10),
                  Text(
                    isArabicLocale ? 'نقاطك الحالية: 1200' : 'Vos points : 1200',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const StoreItemCard(
              title: 'كوبون خصم 10%',
              subtitle: 'قابل للاستبدال في المتجر الداخلي',
              price: 500,
              color: Color(0xFFD71920),
            ),
            const SizedBox(height: 14),
            const StoreItemCard(
              title: 'اشتراك شهر',
              subtitle: 'باقات شهرية داخل التطبيق',
              price: 1200,
              color: Color(0xFFC8A25C),
            ),
            const SizedBox(height: 14),
            const StoreItemCard(
              title: 'هدية رقمية',
              subtitle: 'هدية تفاعلية وتقوية القسم',
              price: 2000,
              color: Color(0xFF1B1B1B),
            ),
          ],
        ),
      ),
    );
  }
}

class StoreItemCard extends StatelessWidget {
  const StoreItemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.color,
  });

  final String title;
  final String subtitle;
  final int price;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(Icons.card_giftcard, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.black54)),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                '$price نقطة',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  showDemoOnlySnackBar(
                    context,
                    'Mode démo : achat non connecté au backend.',
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('استبدال'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
