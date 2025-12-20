import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('О приложении')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Каталог парфюмерно-косметической продукции',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            const Text(
              'Приложение помогает вести каталог любимых средств, отмечать избранное, '
              'строить индивидуальный план ухода и планировать будущие покупки.',
            ),
            const SizedBox(height: 20),
            const Text(
              'Разработчик: Илона Прошутинская, Москва',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            const Text('Контакты:'),
            const Text('• Email: care.catalog@app.example'),
            const Text('• Telegram: @beautyplanner_bot'),
            const Text('• Телефон: +7 (900) 123-45-67'),
            const SizedBox(height: 20),
            const Text(
              'Спасибо, что пользуетесь приложением! Делитесь обратной связью, '
              'чтобы мы могли улучшить ваш опыт ухода за собой.',
            ),
          ],
        ),
      ),
    );
  }
}
