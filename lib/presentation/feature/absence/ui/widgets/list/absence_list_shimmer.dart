import 'package:absence_manager/core/utils/app_color.dart';
import 'package:absence_manager/core/utils/app_size.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/list/round_rectangle.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class AbsenceListShimmer extends StatelessWidget {
  const AbsenceListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: AppHeight.s15);
        },
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return const CardShimmer();
        },
      ),
    );
  }
}

class CardShimmer extends StatelessWidget {
  const CardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRound.s10),
        border: Border.all(color: AppColor.borderColor, width: AppWidth.s1),
        color: AppColor.whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15),
            child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                     RoundedRectangle(
                      width: double.infinity,
                      radius: AppRound.s3,
                    ),
                    Gap(AppHeight.s15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              RoundedRectangle(
                                radius: AppRound.s3,
                                height: AppHeight.s15,
                              ),
                              Gap(AppHeight.s8),
                              RoundedRectangle(
                                radius: AppRound.s3,
                                height: AppHeight.s15,
                              ),
                            ],
                          ),
                        ),

                        Gap(AppWidth.s36),

                        RoundedRectangle(
                          radius: AppRound.s100,
                          width: AppWidth.s70,
                          height: AppHeight.s25,
                        ),

                      ],
                    ),
                  ],
                ),),
          ),
        ],
      ),
    );
  }
}







