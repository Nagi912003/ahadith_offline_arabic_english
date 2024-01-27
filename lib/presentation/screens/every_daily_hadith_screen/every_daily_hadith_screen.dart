import 'package:ahadith_offline_arabic_english/theme/theme_manager.dart';
import 'package:flutter/material.dart';

class EveryDailyHadithScreen extends StatelessWidget {
  const EveryDailyHadithScreen({super.key, required this.dailyAhadith, required this.themeManager, required this.showHadithDetailsFunction});
  final List<Map<String, dynamic>> dailyAhadith;
  final ThemeManager themeManager;
  final Function showHadithDetailsFunction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView.builder(
        itemCount: dailyAhadith.length,
        itemBuilder: (context, i) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: SizedBox(
                height: 80,
                child: Text(
                  themeManager.lang == 'ar'
                      ?dailyAhadith[i]['title_ar']
                      :dailyAhadith[i]['title'],
                  textDirection: themeManager.lang == 'ar'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  overflow: TextOverflow.fade,
                ),
              ),
              onTap: (){
                showHadithDetailsFunction(dailyAhadith[i]);
              },
            ),
            const Divider(indent: 20, endIndent: 20),
          ],
        ),
      ),
    );
  }
}
