import 'package:ahadith_offline_arabic_english/business_logic/search_algorithm/search_controller.dart';
import 'package:ahadith_offline_arabic_english/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../helpers/notification_service.dart';
// import '../all_hadith_screen/all_hadith_screen.dart';
import '../every_daily_hadith_screen/every_daily_hadith_screen.dart';
import '../daily_hadith_screen/daily_hadith_screen.dart';
import 'widgets/blurred_container.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.themeManager});
  final ThemeManager themeManager;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NotificationsServices notificationsServices = NotificationsServices();
  int _currentIndex = 1;
  final PageController _pageController = PageController(initialPage: 1);

  @override
  void initState() {
    // Provider.of<SearchProvider>(context, listen: false)
    //     .buildInvertedIndex();
    // Provider.of<SearchProvider>(context, listen: false).dailyHadith;
    notificationsServices.initialiseNotifications();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic> dailyHadith =
        Provider.of<SearchProvider>(context, listen: false).dailyHadith;
    final List<Map<String, dynamic>> dailyAhadith =
        Provider.of<SearchProvider>(context, listen: false).dailyAhadith;
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: widget.themeManager.appPrimaryColor200,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: OurAppbar(),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: BlurredContainer(
              child: SizedBox(
                // color: Colors.black,
                height: MediaQuery.of(context).size.height * 0.85,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  widget.themeManager.bgImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: [
              EveryDailyHadithScreen(
                dailyAhadith: dailyAhadith,
                themeManager: widget.themeManager,
                showHadithDetailsFunction: _showDialog,
              ),
              DailyHadithScreen(
                dailyHadith: dailyHadith,
                themeManager: widget.themeManager,
                showHadithDetailsFunction: _showDialog,
              ),
              // AllHadithScreen(
              //   themeManager: widget.themeManager,
              // ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: widget.themeManager.appPrimaryColor200,
        onTap: _onNavItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list_alt,
              color: widget.themeManager.appPrimaryColor,
            ),
            label: widget.themeManager.lang == 'ar'
                ? 'الأحاديث اليومية السابقة'
                : 'Every Daily Hadith',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shuffle,
              color: widget.themeManager.appPrimaryColor,
            ),
            label: widget.themeManager.lang == 'ar'
                ? 'الحديث اليومي'
                : 'Daily Hadith',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.list,
          //     color: widget.themeManager.appPrimaryColor,
          //   ),
          //   label: widget.themeManager.lang == 'ar' ? 'موسوعه الاحاديث' :'All Ahadith',
          // ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.black54,
        child: ListView(children: [
          DrawerHeader(
            child: SizedBox(
              height: 200,
              child: Card(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'اللَهُمَّ صّلِ وسَلّمْ عَلى نَبِيْنَا مُحَمد ﷺ',
                      style: TextStyle(
                        fontSize: 30.sp,
                        color: widget.themeManager.appPrimaryColor200,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              trailing: DropdownButton<String>(
                iconDisabledColor: widget.themeManager.appPrimaryColor200,
                iconEnabledColor: widget.themeManager.appPrimaryColor,
                borderRadius: BorderRadius.circular(10),
                isDense: true,
                items: [
                  DropdownMenuItem(
                    value: 'ar',
                    child: Text(
                      'العربية',
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Theme.of(context).textTheme.bodySmall!.color,
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'en',
                    child: Text(
                      'English',
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Theme.of(context).textTheme.bodySmall!.color,
                      ),
                    ),
                  ),
                ],
                value: widget.themeManager.lang,
                icon: Icon(
                  Icons.language,
                  color: widget.themeManager.appPrimaryColor200,
                ),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Theme.of(context).textTheme.bodySmall!.color,
                ),
                underline: const SizedBox(height: 0),
                onChanged: (String? newValue) {
                  setState(() {
                    widget.themeManager.lang = newValue!;
                    widget.themeManager.toggleLang(newValue);
                  });
                },
              ),
              title: Text(
                widget.themeManager.lang == 'ar' ? 'اللغة' : 'Language',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Theme.of(context).textTheme.bodySmall!.color,
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                widget.themeManager.lang == 'ar' ? 'حجم الخط' : 'Font Size',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Theme.of(context).textTheme.bodySmall!.color,
                ),
              ),
              trailing: SizedBox(
                width: 150,
                child: Slider(
                  activeColor: widget.themeManager.appPrimaryColor200,
                  value: widget.themeManager.fontSize,
                  min: -10,
                  max: 10,
                  divisions: 20,
                  label: '${widget.themeManager.fontSize}',
                  onChanged: (double value) {
                    setState(() {
                      widget.themeManager.toggleFontSize(value);
                    });
                  },
                ),
              ),
            ),
          ),
          ListTile(
            leading: IconButton(
              icon: Icon(
                Icons.notifications,
                color: widget.themeManager.appPrimaryColor200,
                size: 30.sp,
              ),
              onPressed: () {
                NotificationsServices notificationsServices =
                    NotificationsServices();
                // notificationsServices.sendNotification('حديث اليوم', 'لا تنسى أذكار الصباح و المساء');
                notificationsServices.sendNotification('حديث اليوم',
                    'صل على نبينا محمد - \nلا تنسى أذكار الصباح و المساء');
              },
            ),
            onTap: null,
          ),
        ]),
      ),
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onNavItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Widget OurAppbar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: 0.75.sw,
        child: Row(
          children: [
            _buildAppBarActions(),
            const Spacer(),
            Text(
              'أَحَادِيـــثٌ',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBarActions() {
    return Row(
      children: [
        DropdownButton<int>(
          iconDisabledColor: widget.themeManager.appPrimaryColor,
          iconEnabledColor: widget.themeManager.appPrimaryColor,
          borderRadius: BorderRadius.circular(10),
          isDense: true,
          items: [
            DropdownMenuItem(
              value: 1,
              child: DropdownMenuItem(
                value: 1,
                child: Image.asset('assets/images/watercolor.png'),
              ),
            ),
            DropdownMenuItem(
              value: 2,
              child: DropdownMenuItem(
                value: 2,
                child: Image.asset('assets/images/watercolor-p.png'),
              ),
            ),
            DropdownMenuItem(
              value: 3,
              child: DropdownMenuItem(
                value: 3,
                child: Image.asset('assets/images/watercolor-off.png'),
              ),
            ),
            DropdownMenuItem(
              value: 4,
              child: DropdownMenuItem(
                value: 4,
                child: Image.asset('assets/images/watercolor-b.png'),
              ),
            ),
            DropdownMenuItem(
              value: 5,
              child: DropdownMenuItem(
                value: 5,
                child: Image.asset('assets/images/watercolor-g.png'),
              ),
            ),
            DropdownMenuItem(
              value: 7,
              child: DropdownMenuItem(
                value: 7,
                child: Image.asset('assets/images/watercolor-bw.png'),
              ),
            ),
            DropdownMenuItem(
              value: 8,
              child: DropdownMenuItem(
                value: 8,
                child: Image.asset('assets/images/watercolor-grey.png'),
              ),
            ),
          ],
          value: widget.themeManager.mode,
          icon: Icon(
            Icons.keyboard_arrow_down_outlined,
            color: widget.themeManager.appPrimaryColor200,
          ),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(
            fontSize: 20.sp,
            color: Theme.of(context).textTheme.bodySmall!.color,
          ),
          underline: const SizedBox(height: 0),
          onChanged: (int? newValue) {
            setState(() {
              widget.themeManager.mode = newValue!;
              widget.themeManager.toggleBackGroundImage(newValue);
            });
          },
        ),
      ],
    );
  }

  void _showDialog(Map<dynamic, dynamic> hadith) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        titlePadding: EdgeInsets.all(8),
        actionsPadding: EdgeInsets.all(8),
        scrollable: true,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              widget.themeManager.lang=='ar'?'الرجوع':'hide',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
        title: widget.themeManager.lang=='ar'? buildCard('', hadith['hadith_text_ar'] + hadith['takhrij_ar'],
            true, context, widget.themeManager):buildCard('', hadith['hadith_text'] + hadith['takhrij'],
            true, context, widget.themeManager),
        content: Column(
          children: [
            widget.themeManager.lang=='ar'?hadithGrade(hadith['grade_ar'], context, widget.themeManager,
                fullScreen: false):hadithGrade(hadith['grade'], context, widget.themeManager,
                fullScreen: false),
            SizedBox(height: 10.h),
            widget.themeManager.lang=='ar'?buildCard('التفسير : ', hadith['explanation_ar'], false, context,
                widget.themeManager):buildCard('explanation : ', hadith['explanation'], false, context,
                widget.themeManager),
          ],
        ),
      ),
    );
  }

  Widget buildCard(String title, String content, bool isHadith,
      BuildContext context, ThemeManager themeManager) {
    return Card(
      color: isHadith
          ? themeManager.appPrimaryColor200
          : Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: RichText(
          textDirection: themeManager.lang=='ar'?TextDirection.rtl:TextDirection.ltr,
          textAlign: TextAlign.end,
          text: WidgetSpan(
            child: SelectableText.rich(
              textDirection: themeManager.lang=='ar'?TextDirection.rtl:TextDirection.ltr ,
              TextSpan(
                text: title,
                style: TextStyle(
                  fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
                  fontSize: Theme.of(context).textTheme.bodySmall!.fontSize! +
                      themeManager.fontSize +
                      2,
                  fontWeight: FontWeight.bold,
                  color: themeManager.appPrimaryColor200,
                ),
                children: [
                  WidgetSpan(
                    child: SelectableText.rich(
                      textDirection: themeManager.lang=='ar'?TextDirection.rtl:TextDirection.ltr ,
                      TextSpan(
                        text: content,
                        style: TextStyle(
                          fontFamily: isHadith
                              ? Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.fontFamily
                              : Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.fontFamily,
                          fontSize: isHadith
                              ? 18.sp + themeManager.fontSize + 2
                              : 19.sp + themeManager.fontSize + 2,
                          fontWeight:
                              isHadith ? FontWeight.bold : FontWeight.normal,
                          color: isHadith
                              ? Colors.black
                              : Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.color, //isHadith ? Colors.black : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget hadithGrade(
      String hadithGrade, BuildContext context, ThemeManager themeManager,
      {bool fullScreen = true}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: themeManager.lang=='ar'?MainAxisAlignment.end:MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            // width: themeManager.lang=='ar'? 200.w : 263.w,
            child: Text(
              hadithGrade,
              style: TextStyle(
                fontSize: 20.sp,
                fontFamily: Theme.of(context).textTheme.bodyLarge!.fontFamily,
                color: themeManager.appPrimaryColor200,
                overflow: TextOverflow.clip,
              ),
              textAlign: themeManager.lang=='ar'?TextAlign.end:TextAlign.start ,
            ),
          ),
          Text(
            themeManager.lang=='ar'?' حديث': '',
            style: TextStyle(
              fontSize: 20.sp,
              fontFamily: Theme.of(context).textTheme.bodyLarge!.fontFamily,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ],
      ),
    );
  }
}
