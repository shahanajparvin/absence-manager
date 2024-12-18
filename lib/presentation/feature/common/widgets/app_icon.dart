import 'package:absence_manager/core/utils/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class AppIcon extends StatelessWidget {
  final String assetName;
  final double height;
  final double width;
  final Color? color;
  final bool isPNG;
  final VoidCallback? onTap;


  const AppIcon({super.key, required this.assetName,  this.height = 22.0 ,  this.width = 22.0, this.color, this.isPNG = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return !isPNG?Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(onTap!=null?20.0:0.0),
        onTap: onTap,
        child: Padding(
          padding: onTap!=null?EdgeInsets.symmetric(horizontal:AppWidth.s8,vertical:AppHeight.s10):EdgeInsets.zero,
          child: SvgPicture.asset(
            assetName,
            height: height,
            width: width,
            colorFilter: color!=null?ColorFilter.mode(color!, BlendMode.srcIn):null,
          ),
        ),
      ),
    ):Image.asset(
      fit: BoxFit.fill,
      assetName,  // Replace with your actual file path
      height: height,
      width: width,
    );
  }
}