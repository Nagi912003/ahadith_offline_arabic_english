import 'package:flutter/material.dart';

class DailyHadithScreen extends StatelessWidget {
  const DailyHadithScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(flex: 1),
          Center(
            child: Text(
                  'Daily Hadith Screen',
                  style: Theme.of(context).textTheme.headline4,
                ),
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
