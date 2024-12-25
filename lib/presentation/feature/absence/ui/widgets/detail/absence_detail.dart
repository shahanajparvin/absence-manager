import 'package:absence_manager/core/utils/app_constant.dart';
import 'package:absence_manager/core/utils/app_image.dart';
import 'package:absence_manager/core/utils/app_size.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_detail/absence_detail_bloc.dart';
import 'package:absence_manager/presentation/feature/absence/model/absence_detail_model.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/detail/absence_detail_title.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/detail/absence_detail_value.dart';
import 'package:absence_manager/presentation/feature/common/widgets/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AbsenceDetailWidget extends StatefulWidget {
  final int absenceId;

  const AbsenceDetailWidget({super.key, required this.absenceId});

  @override
  State<AbsenceDetailWidget> createState() => _AbsenceDetailWidgetState();
}

class _AbsenceDetailWidgetState extends State<AbsenceDetailWidget> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AbsenceDetailBloc>(context)
        .add(FetchAbsenceDetailsEvent(widget.absenceId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbsenceDetailBloc, AbsenceDetailState>(
      builder: (BuildContext context, AbsenceDetailState state) {
        if (state is AbsenceDetailLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AbsenceDetailSuccessState) {
          final AbsenceDetailModel detail = state.absenceDetailView;
          return Padding(
            padding:  EdgeInsets.all(AppWidth.s25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: AppNetworkImage(
                    imageUrl: detail.employeeProfile,
                  ),
                ),
                Gap(AppConst.detailGap),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AbsenceDetailTitle(
                      title: 'Name',
                      iconAsset: AppImage.icName,
                    ),
                    Gap(AppConst.titleGap),
                    AbsenceDetailValue(
                      value: detail.employeeName,
                    )
                  ],
                ),
                Gap(AppConst.detailGap),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AbsenceDetailTitle(
                      title: 'Type of Absence',
                      iconAsset: AppImage.icAbsenceType,
                    ),
                    Gap(AppConst.titleGap),
                    AbsenceDetailValue(
                      value: detail.type,
                    )
                  ],
                ),
                Gap(AppConst.detailGap),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AbsenceDetailTitle(
                      title: 'Start Date',
                      iconAsset: AppImage.icStartDate,
                    ),
                    Gap(AppConst.titleGap),
                    AbsenceDetailValue(
                      value: detail.startDate,
                    )
                  ],
                ),
                Gap(AppConst.detailGap),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AbsenceDetailTitle(
                      title: 'End Date',
                      iconAsset: AppImage.icEndDate,
                    ),
                    Gap(AppConst.titleGap),
                    AbsenceDetailValue(
                      value: detail.endDate,
                    )
                  ],
                ),
                Gap(AppConst.detailGap),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AbsenceDetailTitle(
                      title: 'Total day',
                      iconAsset: AppImage.icTotalCount,
                    ),
                    Gap(AppConst.titleGap),
                    AbsenceDetailValue(
                      value: _getTotalDaysCount(
                          detail.startDate, detail.endDate),
                    )
                  ],
                ),
                Gap(AppConst.detailGap),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AbsenceDetailTitle(
                      title: 'Status',
                      iconAsset: AppImage.icStatus,
                    ),
                    Gap(AppConst.titleGap),
                    AbsenceDetailValue(
                      value: detail.status,
                      color: _getStatusColor(detail.status),
                    )
                  ],
                ),
                if (detail.admitterNote.isNotEmpty)
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(AppConst.detailGap),
                        const AbsenceDetailTitle(
                          title: 'Admitter Note',
                          iconAsset: AppImage.icAdmitTerNote,
                        ),
                        Gap(AppConst.titleGap),
                        AbsenceDetailValue(
                          value: detail.admitterNote,
                        )
                      ]),
                if (detail.memberNote.isNotEmpty)
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(AppConst.detailGap),
                        const AbsenceDetailTitle(
                          title: 'Member Note',
                          iconAsset: AppImage.icMemberNote,
                        ),
                        Gap(AppConst.titleGap),
                        AbsenceDetailValue(
                          value: detail.memberNote,
                        )
                      ]),
              ],
            ),
          );
        } else if (state is AbsenceDetailErrorState) {
          return Center(
            child: Text(
              'Error: ${state.errorMessage}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          return const Center(child: Text('No absence details found.'));
        }
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Requested':
        return Colors.orange;
      case 'Confirmed':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getTotalDaysCount(String fromDate, String toDate) {
    final DateTime from = DateTime.parse(fromDate); // yyyy-mm-dd format
    final DateTime to = DateTime.parse(toDate); // yyyy-mm-dd format
    final Duration difference = to.difference(from);
    return (difference.inDays + 1)
        .toString(); // Adding 1 to include the start date
  }
}
