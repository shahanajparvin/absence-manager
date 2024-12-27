import 'package:absence_manager/core/route/app_route.dart';
import 'package:absence_manager/core/service/ansence_type_service.dart';
import 'package:absence_manager/core/utils/app_color.dart';
import 'package:absence_manager/core/utils/app_size.dart';
import 'package:absence_manager/presentation/feature/absence/model/absence_list_model.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/list/absence_status_widget.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/list/start_end_date_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AbsenceListItem extends StatelessWidget {
  final AbsenceListModel absence;
  final VoidCallback onDetailCallBack;


  const AbsenceListItem(
      {super.key,required this.absence,
        required this.onDetailCallBack,});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: AppColor.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRound.s10),
          side: BorderSide(
            color: AppColor.borderColor,
            width: AppWidth.s1,
          ),
        ),
        child: InkWell(
          splashColor: AppColor.splashColor,
          borderRadius: BorderRadius.circular(AppRound.s10),
          onTap: (){
            context.pushNamed(
              AppRoutes.absenceDetail.name,
              extra: absence.id,
            ).then((_) {
             onDetailCallBack();
            });
          },
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Padding(
                padding: EdgeInsets.all(AppHeight.s15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment : CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              absence.employeeName,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                  color:AppColor.textColorDark, fontWeight: FontWeight.w500,),
                            ),
                          ),
                          Text(
                            AbsenceTypeService(context).convertValueToReadableName(absence.type),
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                color:AppColor.tealColor, fontWeight: FontWeight.w500,),
                          ),
                        ],
                      ),

                      Gap(AppHeight.s15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          StartEndDateWidget(
                              startedOn: absence.startDate,
                              endOn: absence.startDate,),

                          AbsenceStatusWidget(status: absence.status,),

                        ],
                      ),
                    ],),),
          ],),
        ),);
  }
}