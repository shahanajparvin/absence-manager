
import 'package:absence_manager/core/di/injector.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_bloc.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/absence_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbsencePage extends StatefulWidget {
  const AbsencePage({super.key});

  @override
  State<AbsencePage> createState() => _AbsencePageState();
}

class _AbsencePageState extends State<AbsencePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Absence Manager'),
        ),
        body: BlocProvider<AbsenceBloc>(
            create: (_) => injector(),
            child: AbsenceListWidget()
        )
    );
  }
}










