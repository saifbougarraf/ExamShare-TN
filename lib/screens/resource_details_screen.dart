import 'package:flutter/material.dart';

import '../app.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({
    super.key,
    required this.locale,
  });

  final Locale locale;

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final List<String> levels = ['بكالوريا', 'إعدادي', 'جامعي'];
  final List<String> subjects = ['رياضيات', 'فيزياء', 'كيمياء', 'لغة عربية', 'تاريخ'];
  final List<String> types = ['امتحان', 'درس'];
  final List<String> years = ['2021', '2022', '2023', '2024'];

  String selectedLevel = 'بكالوريا';
  String selectedSubject = 'رياضيات';
  String selectedType = 'امتحان';
  String selectedYear = '2024';

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabicLocale = isArabic(locale);

    return Scaffold(
      appBar: AppBar(title: Text(isArabicLocale ? 'رفع ملف جديد' : 'Téléverser une ressource')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isArabicLocale ? 'شارك امتحان أو درس' : 'Partager un examen ou un cours',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1D1D1D),
              ),
            ),
            const SizedBox(height: 18),
            _buildInputField(
              label: isArabicLocale ? 'عنوان الملف' : 'Titre',
              controller: _titleController,
              hint: isArabicLocale ? 'مثال: امتحان فيزياء 2024' : 'Ex. Exam de physique 2024',
            ),
            const SizedBox(height: 14),
            _buildDropdown(
              label: isArabicLocale ? 'المستوى' : 'Niveau',
              value: selectedLevel,
              items: levels,
              onChanged: (v) => setState(() => selectedLevel = v!),
            ),
            const SizedBox(height: 14),
            _buildDropdown(
              label: isArabicLocale ? 'المادة' : 'Matière',
              value: selectedSubject,
              items: subjects,
              onChanged: (v) => setState(() => selectedSubject = v!),
            ),
            const SizedBox(height: 14),
            _buildDropdown(
              label: isArabicLocale ? 'نوع المحتوى' : 'Type de ressource',
              value: selectedType,
              items: types,
              onChanged: (v) => setState(() => selectedType = v!),
            ),
            const SizedBox(height: 14),
            _buildDropdown(
              label: isArabicLocale ? 'السنة' : 'Année',
              value: selectedYear,
              items: years,
              onChanged: (v) => setState(() => selectedYear = v!),
            ),
            const SizedBox(height: 14),
            Text(
              isArabicLocale ? 'وصف المحتوى' : 'Description',
              style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A)),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TextField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: isArabicLocale
                      ? 'اكتب وصفًا مختصرًا: سنة الإمتحان، نوع الأسئلة، المادة...'
                      : 'Décrivez la ressource : année, type de questions, matière...',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFD71920).withOpacity(0.06),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFD71920).withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.upload_file, color: Color(0xFFD71920)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      isArabicLocale ? 'اختر الملف (PDF / صورة)' : 'Choisir un fichier (PDF / image)',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDemoOnlySnackBar(
                        context,
                        isArabicLocale
                            ? 'وضع تجريبي: اختيار الملف غير متصل بالخادم.'
                            : 'Mode démo : ajout de fichier non connecté au backend.',
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD71920),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(isArabicLocale ? 'اختيار' : 'Choisir'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final title = _titleController.text.trim();
                  final description = _descriptionController.text.trim();

                  if (title.isEmpty || description.isEmpty) {
                    showDemoOnlySnackBar(
                      context,
                      isArabicLocale
                          ? 'يرجى ملء عنوان الملف ووصفه.'
                          : 'Veuillez remplir le titre et la description.',
                    );
                    return;
                  }

                  showDemoOnlySnackBar(
                    context,
                    isArabicLocale
                        ? 'وضع تجريبي: لم يتم رفع الملف لأنه غير متصل بالخادم.'
                        : 'Mode démo : le fichier n’a pas été envoyé car le backend n’est pas configuré.',
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
                  isArabicLocale ? 'رفع الملف' : 'Téléverser',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A)),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A)),
        ),
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
