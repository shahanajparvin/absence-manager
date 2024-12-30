import 'dart:async' as debounce;
import 'package:absence_manager/core/di/injector.dart';
import 'package:absence_manager/core/service/filter_handler_service.dart';
import 'package:absence_manager/core/utils/app_constant.dart';
import 'package:absence_manager/core/utils/app_size.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_list/absence_list_bloc.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_list/absence_list_event.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/filter/absence_filter_data_bloc_impl.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/list/absence_filter.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/list/absence_filter_bottom.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/list/absence_filter_header.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/list/absence_list_state_widget.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/list/absence_searce_filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AbsenceListWidget extends StatefulWidget {

  final FilterHandler filterHandler;
  final AbsenceFilterDataBloc absenceFilterDataBloc;

  const AbsenceListWidget({super.key, required this.filterHandler, required this.absenceFilterDataBloc});

  @override
  State<AbsenceListWidget> createState() => _AbsenceListWidgetState();
}

class _AbsenceListWidgetState extends State<AbsenceListWidget> {
  final int _itemsPerPage = 10;

  final ScrollController scrollController = ScrollController();


  final ValueNotifier<bool> isLoadingNotifier = ValueNotifier<bool>(false);

  final TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  debounce.Timer? _debounce;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AbsenceListBloc>(context)
        .add(FetchPaginatedAbsenceEvent(_itemsPerPage));
    searchController.addListener(() => _onSearchChanged(searchController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(AppConst.formPadding),
        child: Column(children: <Widget>[
          SearchFilterBar(
            focusNode: focusNode,
            searchController: searchController,
            onSuffixIconCallback: () => _triggerSearch(''),
            onFilterPressed: _filterIconPressFunctionality,
          ),
          Gap(AppHeight.s10),
          AbsenceListStateWidget(
            focusNode: focusNode,
            scrollController: scrollController,
            isLoadingNotifier: isLoadingNotifier,
            itemsPerPage: _itemsPerPage,
          ),
        ]));
  }

  @override
  void dispose() {
    searchController.dispose();
    focusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = debounce.Timer(const Duration(seconds: 1), () {
      if (query.length >= 2) {
        _triggerSearch(query);
      } else if (query.isEmpty) {
        _resetFilters();
      }
    });
  }

  void _resetFilters() {
    BlocProvider.of<AbsenceListBloc>(context).add(ResetFiltersEvent());
  }

  void _triggerSearch(String query) {
    BlocProvider.of<AbsenceListBloc>(context)
        .add(SearchAbsencesEvent(searchText: query));
  }

  void _filterIconPressFunctionality() {
    widget.filterHandler.showFilterDialog(
        filterHeaderWidget: const AbsenceFilterHeader(),
        filterWidget: AbsenceFilter(
          dataBloc:  widget.absenceFilterDataBloc,
        ),
        context: context,
        dataBloc:  widget.absenceFilterDataBloc,
        filterBottomWidget: AbsenceFilterBottomWidget(
          parentContext: context,
          absenceFilterDataBloc:  widget.absenceFilterDataBloc,
        ));
  }
}
