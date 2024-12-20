import 'dart:async' as debounce;
import 'package:absence_manager/core/di/injector.dart';
import 'package:absence_manager/core/service/filter_handler_service.dart';
import 'package:absence_manager/core/utils/app_constant.dart';
import 'package:absence_manager/core/utils/app_size.dart';
import 'package:absence_manager/core/utils/core_utils.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_list/absence_list_bloc.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_list/absence_list_event.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_list/absence_list_state.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/filter/absence_filter_data_bloc_impl.dart';
import 'package:absence_manager/presentation/feature/absence/model/absence_list_model.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/absence_filter.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/absence_filter_header.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/absence_list_shimmer.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/absence_search_textfield.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/ansence_list_item.dart';
import 'package:absence_manager/presentation/feature/common/widgets/app_no_data_error_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';


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
        resetFilters();
      }
    });
  }

  void _triggerSearch(String query) {
    BlocProvider.of<AbsenceListBloc>(context).add(SearchAbsencesEvent(searchText: query));
  }


  Future<void> _onScroll(BuildContext context) async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent&&context.mounted) {

      isLoadingNotifier.value = true;

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
      if (context.mounted&&context.read<AbsenceListBloc>().state is AbsenceSuccessState &&
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
           ]),
          Gap(AppHeight.s10),
          BlocBuilder<AbsenceListBloc, AbsenceListState>(
            builder: (BuildContext context, AbsenceListState state) {
              if (state is AbsenceInitial || state is AbsenceLoadingState) {
                return const AbsenceListShimmer();
              } else if (state is AbsenceSuccessState) {
                _fetchDataWithNoScroll(state);
                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo)  {
                    if (scrollInfo is ScrollEndNotification) {
                      _onScroll(context);
                    }
                    return false;
                  },
                  child: state.absences.isNotEmpty?Expanded(
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: AppHeight.s15);
                      },
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
                        return AbsenceListItem(
                          absence: absence,
                        );
                      },
                    ),
                  ): Expanded(child: AppNoDataErrorWidget(description: context.text.no_absence_found,)),
                );
              } else if (state is AbsenceErrorState) {
                return Expanded(child: AppNoDataErrorWidget(description: state.errorMessage,isError: true,));
              } else {
                return Expanded(child: AppNoDataErrorWidget(description: context.text.no_absence_found));
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
    BlocProvider.of<AbsenceListBloc>(context).add(FilterAbsencesEvent(type: type,startDate: startDate,endDate: endDate));
  }

  _fetchDataWithNoScroll(AbsenceSuccessState state){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients &&
          scrollController.position.maxScrollExtent <= 0 &&
          state.hasMorePages) {
        BlocProvider.of<AbsenceListBloc>(context).add(FetchPaginatedAbsenceEvent(_itemsPerPage));
      }
    });
  }

  void resetFilters() {
    BlocProvider.of<AbsenceListBloc>(context).add(ResetFiltersEvent());
  }
}

