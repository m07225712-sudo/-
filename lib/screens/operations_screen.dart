import 'package:flutter/material.dart';
import 'home_screen.dart';

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
            const Text('Все операции', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white)),
            const SizedBox(height: 14),
            TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Поиск по названию...',
                hintStyle: const TextStyle(color: Colors.white24),
                prefixIcon: const Icon(Icons.search, color: Colors.white38, size: 20),
                filled: true,
                fillColor: const Color(0xFF122722),
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
                        style: TextStyle(color: Colors.white24, fontSize: 13),
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
                  backgroundColor: const Color(0xFF2E5E54),
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
