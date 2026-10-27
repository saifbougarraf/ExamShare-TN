import 'package:flutter/material.dart';

import '../app.dart';
import '../models/resource.dart';

class ResourceDetailsScreen extends StatelessWidget {
  const ResourceDetailsScreen({
    super.key,
    required this.resource,
    required this.locale,
    required this.onLocaleChanged,
  });

  final Resource resource;
  final Locale locale;
  final void Function(Locale) onLocaleChanged;

  @override
  Widget build(BuildContext context) {
    final isArabicLocale = isArabic(locale);

    return Scaffold(
      appBar: AppBar(title: Text(isArabicLocale ? 'تفاصيل الملف' : 'Détails de la ressource')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Chip(
                        label: Text(resource.level),
                        backgroundColor: const Color(0xFFD71920).withOpacity(0.08),
                        labelStyle: const TextStyle(
                          color: Color(0xFFD71920),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Chip(
                        label: Text(resource.resourceType),
                        backgroundColor: const Color(0xFFC8A25C).withOpacity(0.12),
                        labelStyle: const TextStyle(
                          color: Color(0xFF7A5B1D),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    resource.title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${isArabicLocale ? 'المادة' : 'Matière'}: ${resource.subject}',
                    style: const TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${isArabicLocale ? 'السنة' : 'Année'}: ${resource.year}',
                    style: const TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    resource.description,
                    style: const TextStyle(fontSize: 15, height: 1.7),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      const Icon(Icons.download_rounded, color: Colors.black54),
                      const SizedBox(width: 8),
                      Text('${resource.downloads} ${isArabicLocale ? 'تنزيلات' : 'téléchargements'}'),
                      const Spacer(),
                      const Icon(Icons.stars, color: Color(0xFFC8A25C)),
                      const SizedBox(width: 8),
                      Text('${resource.points} ${isArabicLocale ? 'نقطة' : 'points'}'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDemoOnlySnackBar(
                    context,
                    isArabicLocale
                        ? 'وضع تجريبي: فتح/تحميل الملف غير متصل بالخادم.'
                        : 'Mode démo : ouvrir/télécharger non connecté au backend.',
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD71920),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  isArabicLocale ? 'تحميل الملف' : 'Télécharger',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
