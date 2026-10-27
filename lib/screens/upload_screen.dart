import 'package:flutter/material.dart';

import '../app.dart';
import '../data/demo_data.dart';
import '../models/resource.dart';
import 'resource_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.locale,
    required this.onLocaleChanged,
  });

  final Locale locale;
  final void Function(Locale) onLocaleChanged;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  String selectedLevel = 'الكل';
  String selectedSubject = 'الكل';
  String selectedType = 'الكل';

  final List<String> levels = ['الكل', 'بكالوريا', 'إعدادي', 'جامعي'];
  final List<String> subjects = ['الكل', 'رياضيات', 'فيزياء', 'كيمياء', 'لغة عربية', 'تاريخ'];
  final List<String> types = ['الكل', 'امتحان', 'درس'];

  List<Resource> get filteredItems {
    final query = _searchController.text.trim().toLowerCase();

    return demoResources.where((item) {
      final matchesLevel = selectedLevel == 'الكل' || item.level == selectedLevel;
      final matchesSubject = selectedSubject == 'الكل' || item.subject == selectedSubject;
      final matchesType = selectedType == 'الكل' || item.resourceType == selectedType;
      final matchesSearch = query.isEmpty ||
          item.title.toLowerCase().contains(query) ||
          item.subject.toLowerCase().contains(query) ||
          item.description.toLowerCase().contains(query);

      return matchesLevel && matchesSubject && matchesType && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabicLocale = isArabic(widget.locale);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ExamShare TN'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              children: [
                Icon(Icons.stars, color: Color(0xFFC8A25C), size: 18),
                SizedBox(width: 6),
                Text('1200', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isArabicLocale ? 'مرحبًا، أحمد' : 'Bonjour, Ahmed',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isArabicLocale ? 'شارك الاختبارات و اربح نقاطك' : 'Partagez les examens et gagnez des points',
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 18),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: isArabicLocale ? 'بحث في أرشيف الاختبارات والدرسات...' : 'Rechercher une ressource...',
                    hintStyle: const TextStyle(color: Colors.black45),
                    prefixIcon: const Icon(Icons.search, color: Color(0xFFD71920)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              _FilterDropdownRow(
                label: isArabicLocale ? 'المستوى' : 'Niveau',
                value: selectedLevel,
                items: levels,
                onChanged: (v) => setState(() => selectedLevel = v!),
              ),
              const SizedBox(height: 12),
              _FilterDropdownRow(
                label: isArabicLocale ? 'المادة' : 'Matière',
                value: selectedSubject,
                items: subjects,
                onChanged: (v) => setState(() => selectedSubject = v!),
              ),
              const SizedBox(height: 12),
              _FilterDropdownRow(
                label: isArabicLocale ? 'نوع المحتوى' : 'Type',
                value: selectedType,
                items: types,
                onChanged: (v) => setState(() => selectedType = v!),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: StatCard(value: '245', label: isArabicLocale ? 'ملفات' : 'Fichiers', icon: Icons.file_copy_rounded),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StatCard(value: '1200', label: isArabicLocale ? 'نقاطك' : 'Points', icon: Icons.stars),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StatCard(value: '314', label: isArabicLocale ? 'تنزيلات' : 'Téléchargements', icon: Icons.download_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Text(
                isArabicLocale ? 'نتائج البحث' : 'Résultats',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D1D1D),
                ),
              ),
              const SizedBox(height: 12),
              if (filteredItems.isEmpty)
                const EmptyStateCard(
                  title: 'لا توجد نتائج',
                  subtitle: 'جرب تصفية أو كلمة بحث أخرى.',
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final resource = filteredItems[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ResourceDetailsScreen(
                              resource: resource,
                              locale: widget.locale,
                              onLocaleChanged: widget.onLocaleChanged,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        padding: const EdgeInsets.all(16),
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
                            const SizedBox(height: 12),
                            Text(
                              resource.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${resource.subject} • ${resource.description}',
                              style: const TextStyle(color: Colors.black54, fontSize: 13),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                const Icon(Icons.download_rounded, size: 16, color: Colors.black54),
                                const SizedBox(width: 4),
                                Text('${resource.downloads}'),
                                const Spacer(),
                                const Icon(Icons.stars, size: 16, color: Color(0xFFC8A25C)),
                                const SizedBox(width: 4),
                                Text('${resource.points} نقطة'),
                                const Spacer(),
                                ElevatedButton(
                                  onPressed: () {
                                    showDemoOnlySnackBar(
                                      context,
                                      isArabicLocale
                                          ? 'وضع تجريبي: التنزيل غير متصل بالخادم.'
                                          : 'Mode démo : téléchargement non connecté au backend.',
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFD71920),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(isArabicLocale ? 'تحميل' : 'Ouvrir'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => UploadScreen(locale: widget.locale),
            ),
          );
        },
        backgroundColor: const Color(0xFFD71920),
        child: const Icon(Icons.upload_file),
      ),
    );
  }
}

class _FilterDropdownRow extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _FilterDropdownRow({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A))),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              items: items.map((item) {
                return DropdownMenuItem(value: item, child: Text(item));
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

class StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const StatCard({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFFD71920), size: 26),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      ),
    );
  }
}

class EmptyStateCard extends StatelessWidget {
  const EmptyStateCard({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(Icons.search_off_rounded, size: 40, color: Color(0xFFD71920)),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}
