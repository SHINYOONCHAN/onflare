import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:onflare/myhotel.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
    currentDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 8.0),
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
              SizedBox(width: 30),
              Flexible(
                child: CarouselSlider(
                  options: CarouselOptions(
                      height: 40.0, initialPage: 0, viewportFraction: 0.32),
                  items: [
                    currentDate.subtract(Duration(days: 1)),
                    currentDate,
                    currentDate.add(Duration(days: 1)),
                  ].map((DateTime date) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: 180,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            '${date.day}일',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          SizedBox(height: 25),
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
          SizedBox(height: 12),
          MyHotel(
            imagePath: 'assets/images/h1.png',
            channelName: '네트워크 특선 세상 다반사',
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

class CustomUnderlineText extends StatelessWidget {
  final String text;
  final bool isSelected;
  final double fontSize;

  const CustomUnderlineText({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: UnderlinePainter(isSelected, fontSize, text),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: isSelected ? Colors.black : Colors.black,
        ),
      ),
    );
  }
}

class UnderlinePainter extends CustomPainter {
  final bool isSelected;
  final double fontSize;
  final String text;

  UnderlinePainter(this.isSelected, this.fontSize, this.text);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = isSelected ? Colors.black : Colors.transparent
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize,
          color: isSelected ? Colors.black : Colors.transparent,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    final double textWidth = textPainter.width;
    final double startY = size.height + 7.0;
    final double centerX = (textWidth + 4) / 2;

    final Offset start = Offset(centerX - textWidth / 2, startY);
    final Offset end = Offset(centerX + textWidth / 2, startY);

    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
