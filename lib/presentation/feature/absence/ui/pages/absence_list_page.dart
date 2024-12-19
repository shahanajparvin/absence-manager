import 'package:absence_manager/core/di/injector.dart';
import 'package:absence_manager/core/utils/app_color.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_list/absence_list_bloc.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/absence_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbsenceListPage extends StatefulWidget {
  const AbsenceListPage({super.key});

  @override
  State<AbsenceListPage> createState() => _AbsenceListPageState();
}

class _AbsenceListPageState extends State<AbsenceListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Absence Manager'),
        ),
        body: BlocProvider<AbsenceListBloc>(
            create: (_) => injector(),
            child: AbsenceListWidget()
        )
    );
  }
}










