import 'package:ahadith_offline_arabic_english/constants/all_ahadith.dart';
import 'package:ahadith_offline_arabic_english/theme/theme_manager.dart';
import 'package:ahadith_offline_arabic_english/business_logic/search_algorithm/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AllHadithScreen extends StatefulWidget {
  AllHadithScreen({super.key, required this.themeManager});
  ThemeManager themeManager = ThemeManager();

  @override
  State<AllHadithScreen> createState() => _AllHadithScreenState();
}

class _AllHadithScreenState extends State<AllHadithScreen> {
  List<Map<String, dynamic>> Ahadith = allAhadith; // Your data source
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    final searchController = Provider.of<SearchProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            if(value.isNotEmpty){
              setState(() {
                isSearching = true;
                Ahadith = searchController.searchByHadeeth(value, widget.themeManager.lang);
              });
            } else {
              setState(() {
                isSearching = false;
                Ahadith = allAhadith;
              });
            }
          },
          decoration: InputDecoration(
            hintText: widget.themeManager.lang == 'ar'? 'البحث...':'Search...',
            hintStyle: const TextStyle(
              color: Colors.white,
            ),
            hintTextDirection: widget.themeManager.lang == 'ar'
                ? TextDirection.rtl
                : TextDirection.ltr,
            prefixIcon: Icon(
              Icons.search,
              color: widget.themeManager.appPrimaryColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(
                color: widget.themeManager.appPrimaryColor200,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(
                color: widget.themeManager.appPrimaryColor,
              ),
            ),
          ),
          cursorColor: widget.themeManager.appPrimaryColorInverse,
          textDirection: widget.themeManager.lang == 'ar'
              ? TextDirection.rtl
              : TextDirection.ltr,
        ),
        elevation: 0,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: Ahadith.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(
                Ahadith[index]
                    [widget.themeManager.lang == 'ar' ? 'title_ar' : 'title'],
                style: const TextStyle(fontSize: 20),
                textDirection: widget.themeManager.lang == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
              ),
            ),
          );
        },
      ),
    );
  }
}
