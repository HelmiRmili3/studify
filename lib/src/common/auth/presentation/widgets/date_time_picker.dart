import 'package:flutter/material.dart';

class DateTimeSelection extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final IconData? prefixIcon;

  const DateTimeSelection({
    super.key,
    required this.controller,
    this.hintText,
    this.prefixIcon,
  });

  @override
  State<DateTimeSelection> createState() => _DateTimeSelectionState();
}

class _DateTimeSelectionState extends State<DateTimeSelection> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        widget.controller.text =
            "${picked.toLocal()}".split(' ')[0]; // Format: YYYY-MM-DD
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: Theme.of(context).dividerColor,
      ),
    );

    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        // Prevents keyboard interaction
        child: TextFormField(
          controller: widget.controller,
          readOnly: true, // Ensures the field is not editable directly
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).splashColor,
            hintText: widget.hintText ?? "Select Date",
            hintStyle: const TextStyle(
              fontFamily: 'Mulish',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    color: Colors.grey,
                  )
                : null,
            border: border,
            enabledBorder: border,
            focusedBorder: border,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 10,
            ),
          ),
        ),
      ),
    );
  }
}