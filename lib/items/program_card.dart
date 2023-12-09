import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:onflare/controllers/Item_controller.dart';

class ResponsiveCard extends StatefulWidget {
  final String imageUrl;
  final String programTime;
  final String programTitle;

  const ResponsiveCard({
    super.key,
    required this.imageUrl,
    required this.programTime,
    required this.programTitle,
  });

  @override
  FavoritePageState createState() => FavoritePageState();
}

class FavoritePageState extends State<ResponsiveCard> {
  final FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Container(
      width: mq.width * .43,
      constraints: const BoxConstraints(minWidth: 0, maxWidth: 400),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: mq.height * 0.21,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.imageUrl),
                  fit: BoxFit.fill,
                ),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(6)),
                color: Colors.black.withOpacity(0.05),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: mq.width * .409,
                    height: mq.height * .03,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: double.infinity,
                          padding: const EdgeInsets.all(4),
                          decoration: ShapeDecoration(
                            color: Colors.black.withOpacity(0.6),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6),
                                bottomRight: Radius.circular(6),
                              ),
                            ),
                          ),
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'New',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'pretendard',
                                  fontWeight: FontWeight.w500,
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 66,
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 22,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.programTime,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'pretendard',
                            fontWeight: FontWeight.w400,
                            height: 1.6,
                          ),
                        ),
                        Obx(() {
                          bool isFavorite = favoriteController.favorites
                              .contains(widget.programTitle);
                          return GestureDetector(
                            onTap: () {
                              favoriteController
                                  .toggleFavorite(widget.programTitle);
                            },
                            child: SvgPicture.asset(
                                isFavorite
                                    ? 'assets/images/bell.svg'
                                    : 'assets/images/unbell.svg',
                                width: 20,
                                colorFilter: isFavorite
                                    ? const ColorFilter.mode(
                                        Colors.red, BlendMode.srcIn)
                                    : null
                                //color: isFavorite ? Colors.red : null,
                                ),
                          );
                        }),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 28,
                    child: Text(
                      widget.programTitle,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'pretendard',
                        fontWeight: FontWeight.w500,
                        height: 2.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
