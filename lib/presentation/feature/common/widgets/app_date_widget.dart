import 'package:absence_manager/core/mixin/input_decoration_mixin.dart';
import 'package:flutter/material.dart';

class AppDatePickerField extends StatefulWidget {

  final TextEditingController dateController;
  final GlobalKey<FormFieldState<String>>? fieldKey;
  final Function(String?)? onChanged;

  final bool isFilterDate;

  const AppDatePickerField(
      {super.key,

        required this.dateController,
        this.fieldKey,
        this.onChanged,
        this.isFilterDate = false});

  @override
  State<AppDatePickerField> createState() => _AppDatePickerFieldState();
}

class _AppDatePickerFieldState extends State<AppDatePickerField> with InputDecorationMixin{
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      decoration: customInputDecoration(
        labelText: 'Select Date',
        isNoPrefixPadding: true,
        contentPadding: EdgeInsets.zero,
        context: context,
      ),
      onTap: () {
        _selectDate(context);
      },

      controller: widget.dateController,

      onChanged: (value) {
        widget.fieldKey!.currentState!.validate();
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        widget.dateController.text = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      });
    }
  }

}