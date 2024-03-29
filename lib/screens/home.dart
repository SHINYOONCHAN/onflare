import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:onflare/items/program_card.dart';
import 'package:onflare/library/custom_text.dart';
import 'package:onflare/screens/test.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String selectedChannel = '지상파';
  double fontSize = 18.0;
  String selectedLocation = '서울/인천/경기';
  late DateTime currentDate;
  Color black = const Color(0xFF111111);
  Color grey = const Color(0xFFEEEEEE);
  double swipeValue = 0.0;
  late int currentPage;
  late int startingPageIndex;
  late List<int> daysInMonthList;
  late DateTime now = DateTime.now();
  late DateTime date;

  final List<String> items = [
    '서울/인천/경기',
    '부산/경남',
    '대구/경북',
    '광주/전남',
    '전북',
    '대전/세종/충남',
    '충북',
    '강원',
  ];

  @override
  void initState() {
    super.initState();
    tzdata.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
    date = tz.TZDateTime.from(now, tz.local);
    currentPage = startingPageIndex = date.day - 5;
    daysInMonthList = generateDaysInMonthList();
  }

  List<int> generateDaysInMonthList() {
    int daysInMonth = DateTime(date.year, date.month + 1, 0).day;
    int currentDay = date.day;

    int startDay = currentDay - 5;
    int endDay = currentDay + 7;

    startDay = startDay < 1 ? 1 : startDay;
    endDay = endDay > daysInMonth ? daysInMonth : endDay;

    return List.generate(endDay - startDay + 1, (index) => startDay + index);
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: _SliverAppBarDelegate(
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          buildChannelItem('지상파'),
                          buildChannelItem('종합편성'),
                          buildChannelItem('케이블'),
                          buildChannelItem('스카이라이프'),
                          buildChannelItem('해외위성'),
                          buildChannelItem('라디오'),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      height: 1,
                      color: Color(0xFFDDDDDD),
                    ),
                  ],
                ),
              ),
            ),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              items: items
                                  .map(
                                    (String item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                            fontFamily: 'Pretendard',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            color: black,
                                            letterSpacing: -0.025,
                                            height: 1.2),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                  .toList(),
                              value: selectedLocation,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedLocation = value!;
                                });
                              },
                              buttonStyleData: ButtonStyleData(
                                height: 50,
                                width: mq.width * 0.46,
                                padding:
                                    const EdgeInsets.only(left: 14, right: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: grey,
                                ),
                              ),
                              iconStyleData: IconStyleData(
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                ),
                                iconSize: 24,
                                iconEnabledColor: black,
                                iconDisabledColor: black,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 400,
                                width: mq.width * 0.46,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: grey,
                                ),
                                offset: const Offset(0, 0),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness:
                                      MaterialStateProperty.all<double>(6),
                                  thumbVisibility:
                                      MaterialStateProperty.all<bool>(true),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                                padding: EdgeInsets.only(left: 14, right: 14),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  viewportFraction: 0.3,
                                  initialPage: startingPageIndex,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      currentPage = index;
                                    });
                                  },
                                ),
                                items: daysInMonthList
                                    .map(
                                      (item) => Container(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${item.toString()}일",
                                              style: TextStyle(
                                                  fontSize: item ==
                                                          currentPage +
                                                              startingPageIndex
                                                      ? 20.0
                                                      : 16.0,
                                                  fontWeight: item ==
                                                          currentPage +
                                                              startingPageIndex
                                                      ? FontWeight.w600
                                                      : FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'KBS1',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: -0.025,
                                          height: 1.2,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () =>
                                            Get.to(const FavoritePage()),
                                        child: Row(
                                          children: [
                                            const Text(
                                              '전체보기',
                                              style: TextStyle(
                                                fontFamily: 'Pretendard',
                                                color: Color(0xFF585858),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                letterSpacing: -0.025,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            SvgPicture.asset(
                                              width: 8,
                                              'assets/images/arrow_right.svg',
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                Color(0xFF585858),
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      const SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ResponsiveCard(
                              imageUrl:
                                  "https://img.freepik.com/premium-photo/abstract-digital-background-connecting-dots-and-lines_86390-4933.jpg?size=626&ext=jpg",
                              programTime: '13:00',
                              programTitle: 'KBS NEWS',
                            ),
                            SizedBox(width: 8),
                            ResponsiveCard(
                              imageUrl:
                                  "https://img.freepik.com/free-photo/rpa-concept-with-blurry-hand-touching-screen_23-2149311914.jpg?size=626&ext=jpg",
                              programTime: '13:50',
                              programTitle: 'KBS NEWS2',
                            ),
                            SizedBox(width: 8),
                            ResponsiveCard(
                              imageUrl:
                                  "https://img.freepik.com/premium-photo/man-in-the-dark-with-luminous-glasses_324531-800.jpg?size=626&ext=jpg",
                              programTime: '14:30',
                              programTitle: 'KBS NEWS3',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'KBS2',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: -0.025,
                                          height: 1.2,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () =>
                                            Get.to(const FavoritePage()),
                                        child: Row(
                                          children: [
                                            const Text(
                                              '전체보기',
                                              style: TextStyle(
                                                fontFamily: 'Pretendard',
                                                color: Color(0xFF585858),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                letterSpacing: -0.025,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            SvgPicture.asset(
                                              width: 8,
                                              'assets/images/arrow_right.svg',
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                Color(0xFF585858),
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      const SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ResponsiveCard(
                              imageUrl:
                                  "https://img.freepik.com/premium-photo/abstract-digital-background-connecting-dots-and-lines_86390-4933.jpg?size=626&ext=jpg",
                              programTime: '13:00',
                              programTitle: 'KBS2 NEWS',
                            ),
                            SizedBox(width: 8),
                            ResponsiveCard(
                              imageUrl:
                                  "https://img.freepik.com/free-photo/rpa-concept-with-blurry-hand-touching-screen_23-2149311914.jpg?size=626&ext=jpg",
                              programTime: '13:50',
                              programTitle: 'KBS2 NEWS2',
                            ),
                            SizedBox(width: 8),
                            ResponsiveCard(
                              imageUrl:
                                  "https://img.freepik.com/premium-photo/man-in-the-dark-with-luminous-glasses_324531-800.jpg?size=626&ext=jpg",
                              programTime: '14:30',
                              programTitle: 'KBS2 NEWS3',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'MBC',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: -0.025,
                                          height: 1.2,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () =>
                                            Get.to(const FavoritePage()),
                                        child: Row(
                                          children: [
                                            const Text(
                                              '전체보기',
                                              style: TextStyle(
                                                fontFamily: 'Pretendard',
                                                color: Color(0xFF585858),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                letterSpacing: -0.025,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            SvgPicture.asset(
                                              width: 8,
                                              'assets/images/arrow_right.svg',
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                Color(0xFF585858),
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      const SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ResponsiveCard(
                              imageUrl:
                                  "https://img.freepik.com/premium-photo/abstract-digital-background-connecting-dots-and-lines_86390-4933.jpg?size=626&ext=jpg",
                              programTime: '13:00',
                              programTitle: 'MBC NEWS',
                            ),
                            SizedBox(width: 8),
                            ResponsiveCard(
                              imageUrl:
                                  "https://img.freepik.com/free-photo/rpa-concept-with-blurry-hand-touching-screen_23-2149311914.jpg?size=626&ext=jpg",
                              programTime: '13:50',
                              programTitle: 'MBC NEWS2',
                            ),
                            SizedBox(width: 8),
                            ResponsiveCard(
                              imageUrl:
                                  "https://img.freepik.com/premium-photo/man-in-the-dark-with-luminous-glasses_324531-800.jpg?size=626&ext=jpg",
                              programTime: '14:30',
                              programTitle: 'MBC NEWS3',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildChannelItem(String channelName) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedChannel = channelName;
          });
        },
        child: CustomUnderlineText(
            text: channelName,
            isSelected: channelName == selectedChannel,
            fontSize: channelName == selectedChannel ? 20 : 18,
            fontWeight: channelName == selectedChannel
                ? FontWeight.w600
                : FontWeight.w400),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget _widget;

  _SliverAppBarDelegate(this._widget);

  @override
  double get minExtent => 60;

  @override
  double get maxExtent => 60;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return _widget;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return (oldDelegate)._widget != _widget;
  }
}
