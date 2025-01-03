import 'package:absence_manager/presentation/feature/absence/model/absence_list_model.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/list/absence_list_loading.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/list/ansence_list_item.dart';
import 'package:flutter/cupertino.dart';


class AbsenceListView extends StatelessWidget {
  final List<AbsenceListModel> absences;
  final bool hasMorePages;
  final ScrollController scrollController;
  final ValueNotifier<bool> isLoadingNotifier;
  final VoidCallback onScroll;
  final FocusNode focusNode;

  const AbsenceListView({
    super.key,
    required this.absences,
    required this.hasMorePages,
    required this.scrollController,
    required this.isLoadingNotifier,
    required this.onScroll,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo is ScrollEndNotification) {
          onScroll();
        }
        return false;
      },
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 15); // Customize as needed
        },
        padding: EdgeInsets.zero,
        controller: scrollController,
        itemCount: absences.length + (hasMorePages ? 1 : 0),
        itemBuilder: (BuildContext context, int index) {
          if (index == absences.length) {
            return ValueListenableBuilder<bool>(
              valueListenable: isLoadingNotifier,
              builder: (BuildContext context, bool isLoading, Widget? child) {
                return isLoading
                    ? const AbsenceListLoadingWidget()
                    : const SizedBox.shrink();
              },
            );
          }
          final AbsenceListModel absence = absences[index];
          return AbsenceListItem(
            absence: absence,
            onDetailCallBack: () {
              focusNode.unfocus();
            },
          );
        },
      ),
    );
  }
}
