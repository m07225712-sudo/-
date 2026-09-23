import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../presentation/theme/app_colors.dart';

class OperationsScreen extends StatefulWidget {
  final List<Map<String, dynamic>> operations;
  final VoidCallback onAddTap;

  const OperationsScreen({
    super.key,
    required this.operations,
    required this.onAddTap,
  });

  @override
  State<OperationsScreen> createState() => _OperationsScreenState();
}

class _OperationsScreenState extends State<OperationsScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredOps = widget.operations.where((op) {
      final title = op['title'].toString().toLowerCase();
      final category = op['category'].toString().toLowerCase();
      return title.contains(_searchQuery.toLowerCase()) ||
          category.contains(_searchQuery.toLowerCase());
    }).toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Все операции',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text)),
            const SizedBox(height: 14),
            TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              style: const TextStyle(color: AppColors.text, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Поиск по названию...',
                hintStyle: const TextStyle(color: AppColors.textMuted),
                prefixIcon: const Icon(Icons.search,
                    color: AppColors.textMuted, size: 20),
                filled: true,
                fillColor: AppColors.surface,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: filteredOps.isEmpty
                  ? const Center(
                      child: Text(
                        'Записей не найдено',
                        style:
                            TextStyle(color: AppColors.textMuted, fontSize: 13),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredOps.length,
                      itemBuilder: (context, index) {
                        final op = filteredOps[index];
                        return CleanOperationTile(
                          title: op['title']!,
                          category: op['category']!,
                          amount: op['amount']!,
                          date: op['date']!,
                          icon: op['icon']!,
                        );
                      },
                    ),
            ),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: widget.onAddTap,
                child: const Text(
                  '+ Добавить расход',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
