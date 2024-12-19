import 'package:absence_manager/core/di/injector.dart';
import 'package:absence_manager/core/route/app_route.dart';
import 'package:absence_manager/core/service/filter_handler_service.dart';
import 'package:absence_manager/core/utils/core_utils.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_list/absence_list_bloc.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_list/absence_list_event.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_list/absence_list_state.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/filter/absence_filter_data_bloc_impl.dart';
import 'package:absence_manager/presentation/feature/absence/model/absence_list_model.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/absence_filter_header.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/absence_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';




class AbsenceListWidget extends StatefulWidget {
  @override
  State<AbsenceListWidget> createState() => _AbsenceListWidgetState();
}

class _AbsenceListWidgetState extends State<AbsenceListWidget> {

  final int _itemsPerPage = 15;

  final ScrollController scrollController = ScrollController();

  final FilterHandler _filterHandler  = injector();
  final AbsenceFilterDataBloc absenceFilterDataBloc = injector();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AbsenceListBloc>(context).add(FetchPaginatedAbsenceEvent(_itemsPerPage));
  }


  Future<void> _onScroll(BuildContext context) async {
    await AppUtils.delay(const Duration(seconds: 2));

    if (scrollController.position.pixels == scrollController.position.maxScrollExtent&&context.mounted) {
      if (context.read<AbsenceListBloc>().state is AbsenceSuccessState &&
          (context.read<AbsenceListBloc>().state as AbsenceSuccessState).hasMorePages) {
        BlocProvider.of<AbsenceListBloc>(context).add(FetchPaginatedAbsenceEvent(_itemsPerPage));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Filter Widget
         Row(children: [
           const Spacer(),
           IconButton(onPressed:_filterIconPressFunctionality,
               icon: const Icon(Icons.filter))
         ],),

        const Gap(30),

        BlocBuilder<AbsenceListBloc, AbsenceListState>(
          builder: (BuildContext context, AbsenceListState state) {
            if (state is AbsenceLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AbsenceSuccessState) {
              return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo)  {
                  if (scrollInfo is ScrollEndNotification) {

                    _onScroll(context);
                  }
                  return false;
                },
                child: Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: state.absences.length + (state.hasMorePages ? 1 : 0), // Add 1 for loading indicator at the bottom
                    itemBuilder: (BuildContext context, int index) {
                      if (index == state.absences.length) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final AbsenceListModel absence = state.absences[index];
                      return ListTile(
                        onTap: (){
                        context.pushNamed(
                            AppRoutes.absenceDetail.name,
                            extra: absence.id,
                          );
                        },
                        title: Text(absence.employeeName),
                        subtitle: Column(
                          mainAxisSize : MainAxisSize.min,
                          crossAxisAlignment : CrossAxisAlignment.start,
                          children: [
                            Text('Status: ${absence.status}'),
                           Text('Period: ${absence.startDate} - ${absence.endDate}'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            } else if (state is AbsenceErrorState) {
              return Center(
                child: Text('Error: ${state.errorMessage}', style: const TextStyle(color: Colors.red)),
              );
            } else {
              return const Center(child: Text('No absences list found.'));
            }
          },
        ),
      ],
    );
  }

  _filterIconPressFunctionality(){
    _filterHandler.showFilterDialog(
        filterHeaderWidget: const AbsenceFilterHeader(),
        filterWidget:  AbsenceFilter(
          dataBloc: absenceFilterDataBloc,
        ),
        context:context,dataBloc:absenceFilterDataBloc,
        onApply: () async {
          applyFilters(absenceFilterDataBloc.sickType, absenceFilterDataBloc.startDate);
        },
        onReset: () async {

        }
    );
  }

  void applyFilters(String? dateRange, String? type) {
    /*setState(() {
      filteredDateRange = dateRange;
      filteredType = type;
    });*/

    // Trigger data fetch with applied filters
    print("Filters applied:");
    print("Date Range: $dateRange");
    print("Type: $type");
  }
}

