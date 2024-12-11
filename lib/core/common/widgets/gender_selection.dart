import 'package:flutter/material.dart';

class GenderSelection extends StatefulWidget {
  final TextEditingController controller;
  final List<String> options;
  final String? hintText;
  final IconData? prefixIcon;

  const GenderSelection({
    super.key,
    required this.controller,
    required this.options,
    this.hintText,
    this.prefixIcon,
  });

  @override
  State<GenderSelection> createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select Gender",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ...widget.options.map((option) {
                return ListTile(
                  title: Text(option),
                  trailing: widget.controller.text == option
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () {
                    setState(() {
                      widget.controller.text = option;
                    });
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
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
      onTap: _showBottomSheet,
      child: AbsorbPointer(
        // Prevents keyboard interaction
        child: TextFormField(
          controller: widget.controller,
          readOnly: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).splashColor,
            hintText: widget.hintText ?? "Select Gender",
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
            suffixIcon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
            ),
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
