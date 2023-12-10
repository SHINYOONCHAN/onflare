import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onflare/controller/item_controller.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  FavoritePageState createState() => FavoritePageState();
}

class FavoritePageState extends State<FavoritePage> {
  final FavoriteController favoriteController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알림 리스트'),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: favoriteController.favorites.length,
          itemBuilder: (context, index) {
            String itemTitle = favoriteController.favorites[index];
            return ListTile(
              title: Text(itemTitle),
              trailing: GestureDetector(
                onTap: () {
                  favoriteController.toggleFavorite(itemTitle);
                },
                child: SvgPicture.asset('assets/images/bell.svg',
                    width: 20,
                    colorFilter:
                        const ColorFilter.mode(Colors.red, BlendMode.srcIn)),
              ),
            );
          },
        );
      }),
    );
  }
}
