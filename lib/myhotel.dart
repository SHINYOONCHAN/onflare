import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHotel extends StatefulWidget {
  final String imagePath;
  final String channelName;

  MyHotel({
    required this.imagePath,
    required this.channelName,
  });

  @override
  _MyHotelState createState() => _MyHotelState();
}

class _MyHotelState extends State<MyHotel> {
  bool isBellIconSelected = false;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          width: mq.width * 0.35,
          decoration: ShapeDecoration(
            image: DecorationImage(
              image: AssetImage(widget.imagePath),
              fit: BoxFit.fill,
            ),
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFFDFE0E4)),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Stack(
            children: [
              Container(
                width: mq.width * 0.35,
                height: mq.height * 0.25,
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: const Alignment(0.00, -1.00),
                    end: const Alignment(0, 2),
                    colors: [Colors.black.withOpacity(0), Colors.black],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Positioned(
                left: 8,
                bottom: 32,
                child: Text(
                  widget.channelName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Pretendard',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.025,
                    height: 2.0,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isBellIconSelected = !isBellIconSelected;
                    });
                  },
                  child: SvgPicture.asset(
                    isBellIconSelected
                        ? 'assets/images/bell.svg'
                        : 'assets/images/unbell.svg',
                    width: 22,
                    height: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
