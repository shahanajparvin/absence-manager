import 'dart:async' as debounce;

import 'package:absence_manager/core/di/injector.dart';
import 'package:absence_manager/core/route/app_route.dart';
import 'package:absence_manager/core/service/filter_handler_service.dart';
import 'package:absence_manager/core/utils/app_constant.dart';
import 'package:absence_manager/core/utils/core_utils.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_list/absence_list_bloc.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_list/absence_list_event.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_list/absence_list_state.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/filter/absence_filter_data_bloc_impl.dart';
import 'package:absence_manager/presentation/feature/absence/model/absence_list_model.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/absence_filter.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/absence_filter_header.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/absence_search_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';



class AbsenceListWidget extends StatefulWidget {
  @override
  State<AbsenceListWidget> createState() => _AbsenceListWidgetState();
}

class _AbsenceListWidgetState extends State<AbsenceListWidget> {

  final int _itemsPerPage = 10;

  final ScrollController scrollController = ScrollController();

  final FilterHandler _filterHandler  = injector();
  final AbsenceFilterDataBloc absenceFilterDataBloc = injector();
  final ValueNotifier<bool> isLoadingNotifier = ValueNotifier<bool>(false);

  final TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  debounce.Timer? _debounce;


  @override
  void initState() {
    super.initState();
    BlocProvider.of<AbsenceListBloc>(context).add(FetchPaginatedAbsenceEvent(_itemsPerPage));
    searchController
        .addListener(() => _onSearchChanged(searchController.text));
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = debounce.Timer(const Duration(seconds: 1), () {
      if (query.length >= 2) {
        _triggerSearch(query);
      } else if (query.isEmpty) {

      }
    });
  }

  void _triggerSearch(String query) {

  }


  Future<void> _onScroll(BuildContext context) async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent&&context.mounted) {

      isLoadingNotifier.value = true;

      // Wait for the widget tree to update
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent, // Target the latest max extent
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });


      await AppUtils.delay(const Duration(seconds: 2));
      if (context.read<AbsenceListBloc>().state is AbsenceSuccessState &&
          (context.read<AbsenceListBloc>().state as AbsenceSuccessState).hasMorePages) {
        BlocProvider.of<AbsenceListBloc>(context).add(FetchPaginatedAbsenceEvent(_itemsPerPage));

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(AppConst.formPadding),
      child: Column(
        children: <Widget>[
          Row(children: <Widget>[
            Expanded(
              child: AbsenceSearchBar(
                 focusNode: focusNode,
                searchController: searchController,
                 onSuffixIconCallBack: (){
                   _triggerSearch('');
                 },
               ),
            ),
             IconButton(onPressed:_filterIconPressFunctionality,
                 icon: const Icon(Icons.filter))
           ],),

          const Gap(10),

          BlocBuilder<AbsenceListBloc, AbsenceListState>(
            builder: (BuildContext context, AbsenceListState state) {
              if (state is AbsenceLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AbsenceSuccessState) {

                // Post-build check for fetching more items if no scrolling is possible
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (scrollController.hasClients &&
                      scrollController.position.maxScrollExtent <= 0 &&
                      state.hasMorePages) {
                    BlocProvider.of<AbsenceListBloc>(context).add(FetchPaginatedAbsenceEvent(_itemsPerPage));
                  }
                });

                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo)  {
                    if (scrollInfo is ScrollEndNotification) {
                      _onScroll(context);
                    }
                    return false;
                  },
                  child: Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      controller: scrollController,
                      itemCount: state.absences.length + (state.hasMorePages ? 1 : 0), // Add 1 for loading indicator at the bottom
                      itemBuilder: (BuildContext context, int index) {
                        if (index == state.absences.length) {
                          return ValueListenableBuilder<bool>(
                            valueListenable: isLoadingNotifier,
                            builder: (BuildContext context, bool isLoading, Widget? child) {
                              return isLoading
                                  ? Container(
                                  height: 100,
                                  color: Colors.amber,
                                  child: const Center(child: CupertinoActivityIndicator()))
                                  : const SizedBox.shrink();
                            },
                          );
                        }
                        final AbsenceListModel absence = state.absences[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          onTap: (){
                          context.pushNamed(
                              AppRoutes.absenceDetail.name,
                              extra: absence.id,
                            );
                          },
                          title: SizedBox(
                              height: 20,
                              child: Text(absence.employeeName)),
                          subtitle: Column(
                            mainAxisSize : MainAxisSize.min,
                            crossAxisAlignment : CrossAxisAlignment.start,
                            children: <Widget>[
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
      ),
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
          applyFilters(
              startDate: absenceFilterDataBloc.startDate,
              endDate: absenceFilterDataBloc.endDate,
              type: absenceFilterDataBloc.sickType);
        },
        onReset: () async {
          resetFilters();
        }
    );
  }

  void applyFilters({ String? type,String? startDate, String? endDate,}) {
    debugPrint("Filters applied:");
    debugPrint("Date Range: $startDate");
    debugPrint("startDate: $startDate");
    debugPrint("endDate: $endDate");
    BlocProvider.of<AbsenceListBloc>(context).add(FilterAbsencesEvent(type: type,startDate: startDate,endDate: endDate));
  }

  void resetFilters() {
    BlocProvider.of<AbsenceListBloc>(context).add(ResetFiltersEvent());
  }
}

