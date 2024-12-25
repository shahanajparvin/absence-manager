import 'package:absence_manager/core/utils/app_color.dart';
import 'package:absence_manager/core/utils/app_size.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  final String imageUrl;

  const AppNetworkImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
     return CircleAvatar(
       backgroundColor: AppColor.lightGreyColor,
       radius: AppRound.s40,
       backgroundImage: NetworkImage(imageUrl),
       onBackgroundImageError: (_, __) =>
        Icon(Icons.person, size: AppWidth.s40),
     );
  }
}
