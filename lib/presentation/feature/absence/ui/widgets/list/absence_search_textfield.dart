import 'package:absence_manager/core/mixin/input_decoration_mixin.dart';
import 'package:absence_manager/core/utils/app_color.dart';
import 'package:absence_manager/core/utils/app_size.dart';
import 'package:absence_manager/core/utils/core_utils.dart';
import 'package:flutter/material.dart';

class AbsenceSearchBar extends StatefulWidget {
  final VoidCallback onSuffixIconCallBack;
  final TextEditingController searchController;
  final FocusNode focusNode;

  const AbsenceSearchBar({
    super.key,
    required this.onSuffixIconCallBack,
    required this.searchController,
    required this.focusNode,
  });

  @override
  _AbsenceSearchBarState createState() => _AbsenceSearchBarState();
}

class _AbsenceSearchBarState extends State<AbsenceSearchBar>
    with InputDecorationMixin {
  late ValueNotifier<bool> _showSuffixIcon;

  @override
  void initState() {
    super.initState();
    _showSuffixIcon =
        ValueNotifier<bool>(widget.searchController.text.isNotEmpty);
    widget.searchController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    _showSuffixIcon.value = widget.searchController.text.isNotEmpty;
  }

  @override
  void dispose() {
    widget.searchController.removeListener(_onTextChanged);
    _showSuffixIcon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
          focusNode: widget.focusNode,
          controller: widget.searchController,
          decoration: customInputDecoration(
            fillColor: AppColor.whiteColor,
            contentPadding: EdgeInsets.zero,
            hintText: context.text.search_leave_by_name,
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: AppWidth.s10),
              child: const Icon(Icons.search)
            ),
            suffixIcon: ValueListenableBuilder<bool>(
              valueListenable: _showSuffixIcon,
              builder: (BuildContext context, bool showSuffixIcon, Widget? child) {
                return showSuffixIcon
                    ? IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.grey.shade500,
                      ), // Close icon to clear the search box
                      onPressed: () {
                        widget.searchController.clear(); // Clear the text
                        widget.onSuffixIconCallBack(); // Call the callback
                      },
                    )
                    : const SizedBox();
              },
            ),
            context: context,
          ),
        );
  }

}
