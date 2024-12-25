import 'package:absence_manager/core/utils/app_color.dart';
import 'package:absence_manager/core/utils/app_image.dart';
import 'package:absence_manager/core/utils/app_size.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/absence_filter_icon.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/absence_search_textfield.dart';
import 'package:absence_manager/presentation/feature/common/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SearchFilterBar extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController searchController;
  final VoidCallback onSuffixIconCallback;
  final VoidCallback onFilterPressed;

  const SearchFilterBar({
    super.key,
    required this.focusNode,
    required this.searchController,
    required this.onSuffixIconCallback,
    required this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: AbsenceSearchBar(
            focusNode: focusNode,
            searchController: searchController,
            onSuffixIconCallBack: onSuffixIconCallback,
          ),
        ),
        Gap(AppWidth.s10),
        FilterIconButton(onPressed: onFilterPressed),
      ],
    );
  }

}
