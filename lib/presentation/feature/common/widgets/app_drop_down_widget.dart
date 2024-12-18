import 'package:absence_manager/core/mixin/input_decoration_mixin.dart';
import 'package:absence_manager/core/utils/app_color.dart';
import 'package:absence_manager/core/utils/app_constants.dart';
import 'package:absence_manager/core/utils/app_size.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class AppOverlayDropDown extends StatefulWidget {
  final String hintText;
  final List<String> items;
  final Function(String?) onSelectCallBack;
  final String? initialValue;
  final String label;

  const AppOverlayDropDown(
      {super.key,
        required this.items,
        required this.hintText,
        required this.onSelectCallBack,
        this.initialValue, required this.label});

  @override
  State<AppOverlayDropDown> createState() => _AppOverlayDropDownState();
}

class _AppOverlayDropDownState extends State<AppOverlayDropDown>
    with InputDecorationMixin {
  bool _isDropdownOpen = false;

  String? selectedValue;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null &&
        !widget.items.any((item) =>
        item.toLowerCase() == widget.initialValue!.toLowerCase())) {
      selectedValue = null;
    } else if(widget.initialValue != null){
      selectedValue = widget.items.firstWhere(
              (item) => item.toLowerCase() == widget.initialValue!.toLowerCase());
    }
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = _isDropdownOpen
        ? BorderRadius.only(
      topLeft: Radius.circular(AppConst.textFieldBorderRadius),
      topRight: Radius.circular(AppConst.textFieldBorderRadius),
    )
        : BorderRadius.circular(AppConst.textFieldBorderRadius);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        textFieldLabel(
            context: context,
            label: widget.label),
        SizedBox(
          width: double.infinity,
          child: DropdownButtonFormField2<String>(
            alignment: AlignmentDirectional.topStart,  // Align button to start
            onMenuStateChange: (isOpen) {
              _isDropdownOpen = !_isDropdownOpen;
              if (isOpen) {
                _isDropdownOpen = true;
              } else {
                _isDropdownOpen = false;
              }
              setState(() {});
            },
            buttonStyleData: const ButtonStyleData(
              elevation: 0, // Remove elevation
            ),
            decoration: customInputDecoration(
              isNoPrefixPadding: true,
              contentPadding: EdgeInsets.zero,
              context: context,
              borderRadius: borderRadius,
            ),
            hint: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppConst.textFieldHorizontalPadding),
              child: Text(widget.hintText,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: AppColor.darkGreyColor,
                  )),
            ),
            items: _addDividersAfterItems(widget.items, context),
            value: selectedValue,
            onChanged: (String? value) {
              widget.onSelectCallBack(value);
            },
            dropdownStyleData: DropdownStyleData(
              elevation: 2,
              decoration: BoxDecoration(
                color: AppColor.greyBgColor,
                border: const Border(
                  left: BorderSide(color: AppColor.lightGreyColor),
                  right: BorderSide(color: AppColor.lightGreyColor),
                  bottom: BorderSide(color: AppColor.lightGreyColor),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(AppConst.textFieldBorderRadius),
                  bottomRight: Radius.circular(AppConst.textFieldBorderRadius),
                ),
              ),
              maxHeight: AppHeight.s300,
            ),
            menuItemStyleData: MenuItemStyleData(
              padding: EdgeInsets.zero,
              customHeights: _getCustomItemsHeights(widget.items),
            ),
            iconStyleData: IconStyleData(
              icon: Padding(
                padding: EdgeInsets.only(right: AppWidth.s10),
                child: const Icon(Icons.keyboard_arrow_down),
              ),
              openMenuIcon: Padding(
                padding: EdgeInsets.only(right: AppWidth.s10),
                child: const Icon(Icons.keyboard_arrow_up),
              ),
            ),
          ),
        )
      ],
    );

  }
}

List<DropdownMenuItem<String>> _addDividersAfterItems(
    List<String> items, BuildContext context) {
  final List<DropdownMenuItem<String>> menuItems = [];
  for (final String item in items) {
    menuItems.addAll(
      [
        DropdownMenuItem<String>(
          value: item,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppConst.textFieldHorizontalPadding),
            child: Text(item,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith()),
          ),
        ),
        //If it's last item, we will not add Divider after it.
        if (item != items.last)
          DropdownMenuItem<String>(
            enabled: false,
            child: Container(
                height: AppHeight.s2, color: AppColor.lightGreyColor),
          ),
      ],
    );
  }
  return menuItems;
}

List<double> _getCustomItemsHeights(List<String> items) {
  final List<double> itemsHeights = [];
  for (int i = 0; i < (items.length * 2) - 1; i++) {
    if (i.isEven) {
      itemsHeights.add(AppHeight.s42);
    }
    //Dividers indexes will be the odd indexes
    if (i.isOdd) {
      itemsHeights.add(AppHeight.s4);
    }
  }
  return itemsHeights;
}