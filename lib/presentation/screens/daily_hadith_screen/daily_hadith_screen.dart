import 'package:ahadith_offline_arabic_english/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DailyHadithScreen extends StatelessWidget {
  const DailyHadithScreen(
      {super.key, required this.dailyHadith, required this.themeManager, required this.showHadithDetailsFunction});
  final Map<dynamic, dynamic> dailyHadith;
  final ThemeManager themeManager;
  final Function showHadithDetailsFunction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          const Spacer(flex: 5),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                themeManager.lang == 'ar'
                    ?'حديـــــث اليوم': 'Daily Hadith',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                  fontSize: 32.sp,
                ),
                textAlign: TextAlign.center,
              ),
              InkWell(
                onTap: (){
                  showHadithDetailsFunction(dailyHadith);
                },
                child: Container(
                  height: 0.4.sh,
                  padding: const EdgeInsets.only(right: 20, left: 20, top: 30),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Text(
                        themeManager.lang == 'ar'
                            ? dailyHadith['hadith_text_ar']
                            : dailyHadith['hadith_text'],
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 22 + themeManager.fontSize,overflow: TextOverflow.fade
                            ),
                        textDirection: themeManager.lang == 'ar'
                            ? TextDirection.rtl:TextDirection.ltr ,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(flex: 9),
        ],
      ),
    );
  }
}
