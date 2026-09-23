import 'package:flutter/material.dart';

import '../presentation/theme/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Настройки',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text)),
            const SizedBox(height: 24),
            const Text('Имя пользователя',
                style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
            const SizedBox(height: 6),
            TextField(
              controller: TextEditingController(text: 'оппал'),
              style: const TextStyle(color: AppColors.text),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Text('Валюта',
                style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              initialValue: 'COM',
              dropdownColor: AppColors.surface,
              style: const TextStyle(color: AppColors.text),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'COM', child: Text('COM (сомов)')),
                DropdownMenuItem(value: 'USD', child: Text('USD (\$)')),
                DropdownMenuItem(value: 'RUB', child: Text('RUB (₽)')),
              ],
              onChanged: (val) {},
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () {},
                child: const Text('Сохранить',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
