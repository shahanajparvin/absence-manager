import 'package:absence_manager/core/di/injector.dart';
import 'package:absence_manager/core/utils/app_color.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_detail/absence_detail_bloc.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_list/absence_list_bloc.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/absence_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbsenceDetailPage extends StatelessWidget {

  final int absenceId;

  const AbsenceDetailPage({super.key, required this.absenceId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Absence Detail'),
        ),
        body: BlocProvider<AbsenceDetailBloc>(
            create: (_) => injector(),
            child: AbsenceDetailWidget(absenceId: absenceId)
        )
    );
  }
}










