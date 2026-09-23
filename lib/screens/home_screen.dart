import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> operations;
  final VoidCallback onSeeAllTap;

  const HomeScreen({
    super.key,
    required this.operations,
    required this.onSeeAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Добро пожаловать,', style: TextStyle(color: Colors.white38, fontSize: 13)),
                  SizedBox(height: 2),
                  Text('оплал', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white)),
                ],
              ),
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFF18312A),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.person_outline, color: Color(0xFF73A89C), size: 20),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF142923),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Расходы за сегодня', style: TextStyle(color: Colors.white38, fontSize: 12)),
                const SizedBox(height: 6),
                const Text('201 113 сом', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 18),
                Divider(color: Colors.white.withValues(alpha: 0.06), height: 1),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('За месяц', style: TextStyle(color: Colors.white38, fontSize: 11)),
                        SizedBox(height: 2),
                        Text('201 113 сом', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('Операций', style: TextStyle(color: Colors.white38, fontSize: 11)),
                        const SizedBox(height: 2),
                        Text('${operations.length}', style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Последние операции', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
              GestureDetector(
                onTap: onSeeAllTap,
                child: const Text('Все операции', style: TextStyle(color: Color(0xFF73A89C), fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...operations.map((op) => CleanOperationTile(
                title: op['title']!,
                category: op['category']!,
                amount: op['amount']!,
                date: op['date']!,
                icon: op['icon']!,
              )),
        ],
      ),
    );
  }
}

class CleanOperationTile extends StatelessWidget {
  final String title;
  final String category;
  final String amount;
  final String date;
  final String icon;

  const CleanOperationTile({
    super.key,
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF122722),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF1B362F),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(icon, style: const TextStyle(fontSize: 16)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 14)),
                Text(category, style: const TextStyle(color: Colors.white38, fontSize: 11)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 13)),
              Text(date, style: const TextStyle(color: Colors.white24, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }
}
