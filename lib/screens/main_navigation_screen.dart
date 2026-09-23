import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repository/app_repository.dart';
import 'package:auto_route/auto_route.dart';
import '../presentation/theme/app_colors.dart';
import 'home_screen.dart';
import 'operations_screen.dart';
import 'categories_screen.dart';
import 'settings_screen.dart';

@RoutePage()
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadSavedOperations();
  }

  final List<Map<String, dynamic>> _operations = [
    {
      'title': 'Продукты',
      'category': 'Еда',
      'amount': '- 6 165 сом',
      'date': '21.09.2026',
      'icon': '🍔'
    },
    {
      'title': 'Аренда',
      'category': 'Дом',
      'amount': '- 98 989 сом',
      'date': '21.09.2026',
      'icon': '🏠'
    },
    {
      'title': 'Покупки',
      'category': 'Другое',
      'amount': '- 95 959 сом',
      'date': '21.09.2026',
      'icon': '📦'
    },
  ];

  final List<Map<String, String>> _categories = [
    {'name': 'Еда', 'icon': '🍔'},
    {'name': 'Транспорт', 'icon': '🚖'},
    {'name': 'Покупки', 'icon': '🛒'},
    {'name': 'Развлечения', 'icon': '🎮'},
    {'name': 'Здоровье', 'icon': '💊'},
    {'name': 'Образование', 'icon': '📚'},
    {'name': 'Дом', 'icon': '🏠'},
    {'name': 'Другое', 'icon': '📦'},
  ];

  Future<void> _loadSavedOperations() async {
    final transactions = await context.read<AppRepository>().fetchTransactions();
    if (!mounted || transactions.isEmpty) return;

    setState(() {
      _operations
        ..clear()
        ..addAll(transactions.reversed.map((transaction) => {
              'title': transaction.comment ?? transaction.category,
              'category': transaction.category,
              'amount': '- ${transaction.amount.toStringAsFixed(2)} сом',
              'date': '${transaction.date.day.toString().padLeft(2, '0')}.${transaction.date.month.toString().padLeft(2, '0')}.${transaction.date.year}',
              'icon': transaction.category == 'Еда'
                  ? '🍔'
                  : (transaction.category == 'Дом' ? '🏠' : '📦'),
            }));
    });
  }

  Future<void> _addOperation(String title, String category, String amount) async {
    final parsedAmount = double.tryParse(amount.replaceAll(',', '.'));
    if (parsedAmount == null || parsedAmount <= 0) return;

    await context.read<AppRepository>().addTransaction(
          title,
          parsedAmount,
          0,
          category,
        );

    if (!mounted) return;
    setState(() {
      _operations.insert(0, {
        'title': title,
        'category': category,
        'amount': '- ${parsedAmount.toStringAsFixed(2)} сом',
        'date': '${DateTime.now().day.toString().padLeft(2, '0')}.${DateTime.now().month.toString().padLeft(2, '0')}.${DateTime.now().year}',
        'icon': category == 'Еда' ? '🍔' : (category == 'Дом' ? '🏠' : '📦'),
      });
    });
  }

  void _addCategory(String name, String icon) {
    setState(() {
      _categories.add({'name': name, 'icon': icon.isEmpty ? '📁' : icon});
    });
  }

  void _showAddExpenseModal(BuildContext context) {
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    String selectedCategory =
        _categories.isNotEmpty ? _categories.first['name']! : 'Другое';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Новый расход',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: titleController,
              style: const TextStyle(color: AppColors.text),
              decoration: InputDecoration(
                labelText: 'Описание',
                labelStyle: const TextStyle(color: AppColors.textMuted),
                filled: true,
                fillColor: AppColors.surfaceMuted,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: AppColors.text),
              decoration: InputDecoration(
                labelText: 'Сумма (сом)',
                labelStyle: const TextStyle(color: AppColors.textMuted),
                filled: true,
                fillColor: AppColors.surfaceMuted,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            StatefulBuilder(
              builder: (context, setModalState) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceMuted,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButton<String>(
                  value: selectedCategory,
                  isExpanded: true,
                  underline: const SizedBox(),
                  dropdownColor: AppColors.surface,
                  style: const TextStyle(color: AppColors.text),
                  items: _categories
                      .map((c) => DropdownMenuItem(
                            value: c['name'],
                            child: Text(c['name']!),
                          ))
                      .toList(),
                  onChanged: (val) =>
                      setModalState(() => selectedCategory = val!),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (titleController.text.isNotEmpty &&
                      amountController.text.isNotEmpty) {
                    _addOperation(
                      titleController.text.trim(),
                      selectedCategory,
                      amountController.text.trim(),
                    ).then((_) {
                      if (ctx.mounted) Navigator.pop(ctx);
                    });
                  }
                },
                child: const Text(
                  'Добавить',
                  style: TextStyle(
                      color: AppColors.text, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(
        operations: _operations,
        onSeeAllTap: () => setState(() => _currentIndex = 1),
      ),
      OperationsScreen(
        operations: _operations,
        onAddTap: () => _showAddExpenseModal(context),
      ),
      CategoriesScreen(
        categories: _categories,
        onAddCategory: _addCategory,
      ),
      const SettingsScreen(),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddExpenseModal(context),
        backgroundColor: AppColors.accent,
        elevation: 0,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 26),
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.surface,
        elevation: 0,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.grid_view, 'Главная', 0),
              _buildNavItem(Icons.swap_vert, 'Операции', 1),
              const SizedBox(width: 40),
              _buildNavItem(Icons.category_outlined, 'Категории', 2),
              _buildNavItem(Icons.settings_outlined, 'Настройки', 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _currentIndex == index;
    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.primary : AppColors.textMuted,
            size: 22,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isSelected ? AppColors.primary : AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
