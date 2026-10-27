import 'package:flutter/material.dart';

import '../app.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.locale,
  });

  final Locale locale;

  @override
  Widget build(BuildContext context) {
    final isArabicLocale = isArabic(locale);

    return Scaffold(
      appBar: AppBar(title: Text(isArabicLocale ? 'حسابي' : 'Profil')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: const Color(0xFFD71920),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(Icons.person, size: 54, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              'أحمد بن علي',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              isArabicLocale ? 'طالب - جامعة تونس' : 'Étudiant - Université de Tunis',
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: ProfileStatCard(label: isArabicLocale ? 'النقاط' : 'Points', value: '1200')),
                const SizedBox(width: 12),
                Expanded(child: ProfileStatCard(label: isArabicLocale ? 'الملفات' : 'Fichiers', value: '18')),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: ProfileStatCard(label: isArabicLocale ? 'التنزيلات' : 'Téléchargements', value: '314')),
                const SizedBox(width: 12),
                Expanded(child: ProfileStatCard(label: isArabicLocale ? 'التقييم' : 'Note', value: '4.9')),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isArabicLocale ? 'نشاطك الأخير' : 'Activité récente',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const _ActivityRow(
                    title: 'رفع ملف: اختبار فيزياء',
                    subtitle: 'قبل 2 ساعة',
                    icon: Icons.upload_file,
                  ),
                  const Divider(),
                  const _ActivityRow(
                    title: 'تنزيل: مذكرة رياضيات',
                    subtitle: 'اليوم',
                    icon: Icons.download_rounded,
                  ),
                  const Divider(),
                  const _ActivityRow(
                    title: 'استبدال 500 نقطة',
                    subtitle: 'قبل يوم',
                    icon: Icons.card_giftcard,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileStatCard extends StatelessWidget {
  const ProfileStatCard({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Color(0xFFD71920),
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  const _ActivityRow({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFD71920).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFFD71920)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(subtitle, style: const TextStyle(color: Colors.black54)),
            ],
          ),
        ),
      ],
    );
  }
}
