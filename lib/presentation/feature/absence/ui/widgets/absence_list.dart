import 'package:absence_manager/core/utils/core_utils.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_bloc.dart';
import 'package:absence_manager/presentation/feature/absence/model/absence_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:absence_manager/presentation/feature/absence/bloc/absence_bloc.dart';
import 'package:absence_manager/presentation/feature/absence/model/absence_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbsenceListWidget extends StatefulWidget {
  @override
  State<AbsenceListWidget> createState() => _AbsenceListWidgetState();
}

class _AbsenceListWidgetState extends State<AbsenceListWidget> {

  final int _itemsPerPage = 15;

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AbsenceBloc>(context).add(LoadPageEvent(_itemsPerPage));
  }

  // Trigger loading the next page when user scrolls to the bottom
  Future<void> _onScroll() async {
    await AppUtils.delay(Duration(seconds: 2));

    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (context.read<AbsenceBloc>().state is AbsenceSuccessState &&
          (context.read<AbsenceBloc>().state as AbsenceSuccessState).hasMorePages) {
        BlocProvider.of<AbsenceBloc>(context).add(LoadPageEvent(_itemsPerPage));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbsenceBloc, AbsenceState>(
      builder: (BuildContext context, AbsenceState state) {
        if (state is AbsenceLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AbsenceSuccessState) {
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo)  {
              if (scrollInfo is ScrollEndNotification) {

                _onScroll();
              }
              return false;
            },
            child: ListView.builder(
              controller: scrollController,
              itemCount: state.absences.length + (state.hasMorePages ? 1 : 0), // Add 1 for loading indicator at the bottom
              itemBuilder: (context, index) {
                if (index == state.absences.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                final AbsenceListView absence = state.absences[index];
                return ListTile(
                  title: Text(absence.employeeName),
                  subtitle: Text('Status: ${absence.status}'),
                );
              },
            ),
          );
        } else if (state is AbsenceErrorState) {
          return Center(
            child: Text('Error: ${state.errorMessage}', style: const TextStyle(color: Colors.red)),
          );
        } else {
          return const Center(child: Text('No absences found.'));
        }
      },
    );
  }
}

