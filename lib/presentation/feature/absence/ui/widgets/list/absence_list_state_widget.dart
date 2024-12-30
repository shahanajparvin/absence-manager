import 'package:absence_manager/core/utils/app_constant.dart';
import 'package:absence_manager/core/utils/core_utils.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_list/absence_list_bloc.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_list/absence_list_event.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_list/absence_list_state.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/list/absece_list_view.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/list/absence_list_shimmer.dart';
import 'package:absence_manager/presentation/feature/common/widgets/app_no_data_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbsenceListStateWidget extends StatelessWidget {
  final ScrollController scrollController;
  final ValueNotifier<bool> isLoadingNotifier;
  final int itemsPerPage;
  final FocusNode focusNode;

  const AbsenceListStateWidget({
    super.key,
    required this.scrollController,
    required this.isLoadingNotifier,
    required this.itemsPerPage,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbsenceListBloc, AbsenceListState>(
      builder: (BuildContext context, AbsenceListState state) {
        if (state is AbsenceInitial || state is AbsenceLoadingState) {
          return const AbsenceListShimmer();
        } else if (state is AbsenceSuccessState) {
          _fetchDataWithNoScroll(context,state);
          return AbsenceListSuccess(
            focusNode: focusNode,
            state: state,
            scrollController: scrollController,
            isLoadingNotifier: isLoadingNotifier,
            itemsPerPage: itemsPerPage,
          );
        } else if (state is AbsenceErrorState) {
          return Expanded(
            child: AppNoDataErrorWidget(
              description: state.errorMessage,
              isError: true,
            ),
          );
        } else {
          return Expanded(
            child: AppNoDataErrorWidget(description: context.text.no_absence_found),
          );
        }
      },
    );
  }

  void _fetchDataWithNoScroll(BuildContext context,AbsenceSuccessState state){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients &&
          scrollController.position.maxScrollExtent <= 0 &&
          state.hasMorePages) {
        BlocProvider.of<AbsenceListBloc>(context).add(FetchPaginatedAbsenceEvent(itemsPerPage));
      }
    });
  }




}

class AbsenceListSuccess extends StatelessWidget {
  final AbsenceSuccessState state;
  final ScrollController scrollController;
  final ValueNotifier<bool> isLoadingNotifier;
  final int itemsPerPage;
  final FocusNode focusNode;


  const AbsenceListSuccess({
    super.key,
    required this.state,
    required this.scrollController,
    required this.isLoadingNotifier,
    required this.itemsPerPage,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {

        if (scrollInfo is ScrollEndNotification) {
          _onScroll(context);
        }
        return false;
      },
      child: state.absences.isNotEmpty
          ? Expanded(
        child: AbsenceListView(
          focusNode:focusNode,
          absences: state.absences,
          hasMorePages: state.hasMorePages,
          scrollController: scrollController,
          isLoadingNotifier: isLoadingNotifier,
          onScroll: () => _onScroll(context),
        ),
      )
          : Expanded(
        child: AppNoDataErrorWidget(
          description: context.text.no_absence_found,
        ),
      ),
    );
  }
  Future<void> _onScroll(BuildContext context) async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent&&context.mounted) {

      isLoadingNotifier.value = true;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent, // Target the latest max extent
            duration: const Duration(milliseconds: AppConst.delayTime),
            curve: Curves.easeOut,
          );
        }
      });


      await AppUtils.delay(const Duration(milliseconds: AppConst.delayScrollTime));
      if (context.mounted&&context.read<AbsenceListBloc>().state is AbsenceSuccessState &&
          (context.read<AbsenceListBloc>().state as AbsenceSuccessState).hasMorePages) {
        BlocProvider.of<AbsenceListBloc>(context).add(FetchPaginatedAbsenceEvent(itemsPerPage));

      }
    }
  }
}
