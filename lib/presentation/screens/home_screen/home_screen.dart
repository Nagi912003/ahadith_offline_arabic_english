import 'package:ahadith_offline_arabic_english/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../helpers/notification_service.dart';
import '../all_hadith_screen/all_hadith_screen.dart';
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
                height: MediaQuery.of(context).size.height*0.85,
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
            children: const [
              AllHadithScreen(),
              DailyHadithScreen(),
              EveryDailyHadithScreen(),
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
            icon: Icon(Icons.list_alt,
              color: widget.themeManager.appPrimaryColor,
            ),
            label: 'Every Daily Hadith',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shuffle,
              color: widget.themeManager.appPrimaryColor,
            ),
            label: 'Daily Hadith',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list,
              color: widget.themeManager.appPrimaryColor,
            ),
            label: 'All Hadith',
          ),
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
              trailing: Icon(
                Icons.language,
                color: widget.themeManager.appPrimaryColor200,
                size: 30.sp,
              ),
              title: Text(
                'اللغة',
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
                'حجم الخط',
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
                notificationsServices.sendNotification('حديث اليوم', 'صل على نبينا محمد - \nلا تنسى أذكار الصباح و المساء');
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
            // Text(
            //   HijriCalendar.now().toFormat('dd MMMM yyyy'),
            //   style: TextStyle(
            //     fontSize: 18.sp,
            //     color: Theme.of(context).textTheme.bodySmall!.color,
            //   ),
            // ),
            const Spacer(),
            Text(
              'أَحَادِيـــثٌ',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(width: 10),
            _buildAppBarActions(),
          ],
        ),
      ),
    );
  }
  Widget _buildAppBarActions() {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.search,
            color: widget.themeManager.appPrimaryColor,
          ),
          onPressed: () {
            _onPageChanged(2);
            _pageController.animateToPage(
              2,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            /// showSearch ...
          },
        ),
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
}
