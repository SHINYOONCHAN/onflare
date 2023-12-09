import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get/get.dart';
import 'package:onflare/items/program_card.dart';
import 'package:onflare/library/custom_text.dart';
import 'package:onflare/test.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ChannelList(),
      ),
    );
  }
}

class ChannelList extends StatefulWidget {
  const ChannelList({Key? key}) : super(key: key);

  @override
  ChannelListState createState() => ChannelListState();
}

class ChannelListState extends State<ChannelList> {
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
      padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                Row(
                  children: [
                    buildChannelItem('지상파'),
                    buildChannelItem('종합편성'),
                    buildChannelItem('케이블'),
                    buildChannelItem('스카이라이프'),
                    buildChannelItem('해외위성'),
                    buildChannelItem('라디오'),
                  ],
                ),
              ],
            ),
          ),
          const Divider(thickness: 1, height: 1, color: Color(0xFFDDDDDD)),
          const SizedBox(height: 16),
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
                    padding: const EdgeInsets.only(left: 14, right: 14),
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
                      thickness: MaterialStateProperty.all<double>(6),
                      thumbVisibility: MaterialStateProperty.all<bool>(true),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${item.toString()}일",
                                  style: TextStyle(
                                      fontSize: item ==
                                              currentPage + startingPageIndex
                                          ? 20.0
                                          : 16.0,
                                      fontWeight: item ==
                                              currentPage + startingPageIndex
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
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'KBS1',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  color: black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  letterSpacing: -0.025,
                  height: 1.2,
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '전체보기',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      color: Color(0xFF585858),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      letterSpacing: -0.025,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right_rounded,
                    size: 24,
                    color: Color(0xFF585858),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(
                child: ResponsiveCard(
                  imageUrl:
                      "https://search.pstatic.net/common?type=n&size=640x360&quality=100&direct=true&src=https%3A%2F%2Fphinf.pstatic.net%2Ftvcast%2F20221229_229%2FiGvNa_16722952765466IUix_JPEG%2F1672295276531.jpg",
                  programTitle: 'Program 1',
                ),
              ),
              Expanded(
                child: ResponsiveCard(
                  imageUrl:
                      "https://search.pstatic.net/common?type=n&size=640x360&quality=100&direct=true&src=https%3A%2F%2Fphinf.pstatic.net%2Ftvcast%2F20221229_229%2FiGvNa_16722952765466IUix_JPEG%2F1672295276531.jpg",
                  programTitle: 'Program 2',
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () => Get.to(FavoritePage()),
            child: Text('이동'),
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
        ),
      ),
    );
  }
}
