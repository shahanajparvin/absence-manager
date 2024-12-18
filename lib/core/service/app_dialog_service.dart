import 'dart:ui';
import 'package:absence_manager/core/utils/app_constants.dart';
import 'package:absence_manager/core/utils/app_size.dart';
import 'package:absence_manager/presentation/feature/common/widgets/app_close_icon.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:injectable/injectable.dart';


@Injectable()
class AppDialogService {

 void showBlurredChildDialog({
    required BuildContext context,
    required Widget child,
    Widget? bottomChild,
    Widget? headerWidget,
    bool isScroll = false,
    double colorValue = 0.5,
    double filterX = 5.0,
    double filterY = 5.0,
    bool barrierDismissible = false, // Allow customization
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return BlurredBackground(
          colorValue: colorValue,
          filterX: filterX,
          filterY: filterY,
          child: ChildDialog(
            child: child,
            bottomChild: bottomChild,
            headerWidget: headerWidget,
          ),
        );
      },
    );
  }
}

class BlurredBackground extends StatelessWidget {
  final double colorValue;
  final double filterX;
  final double filterY;
  final Widget child;

  const BlurredBackground({
    super.key,
    required this.colorValue,
    required this.filterX,
    required this.filterY,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: filterX, sigmaY: filterY),
          child: Container(
            color: Colors.black.withOpacity(colorValue),
          ),
        ),
        child,
      ],
    );
  }
}

class ChildDialog extends StatelessWidget {
  final Widget child;
  final Widget? bottomChild;
  final Widget? headerWidget;

  const ChildDialog({
    super.key,
    required this.child,
    this.bottomChild,
    this.headerWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding:  EdgeInsets.all(AppConst.formPadding),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context),
             Gap(AppHeight.s15),
            child,
            if (bottomChild != null)
              Padding(
                padding:  EdgeInsets.only(top: AppHeight.s15),
                child: bottomChild!,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (headerWidget != null) headerWidget!,
        CloseIconWidget(onPressed: () => Navigator.of(context).pop()),
      ],
    );
  }
}

