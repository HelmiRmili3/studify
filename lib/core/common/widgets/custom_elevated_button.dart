import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? text; // Nullable text
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final EdgeInsetsGeometry? padding;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    this.text, // Optional text
    this.icon = Icons.arrow_forward_sharp, // Default icon
    required this.backgroundColor,
    required this.foregroundColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center the content
        mainAxisSize: MainAxisSize.min, // Minimize Row's width to content
        children: [
          if (text != null) // Render text only if provided
            Text(
              text!,
              style: TextStyle(
                color: foregroundColor,
                fontFamily: 'Jost',
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          if (text != null)
            const SizedBox(width: 8.0), // Add space between text and icon
          Container(
            decoration: BoxDecoration(
              color: foregroundColor,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(6.0),
            child: Icon(
              icon,
              color: backgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';

// class CustomButton extends StatelessWidget {
//   final VoidCallback onPressed;
//   final String? text; // Nullable text
//   final IconData icon;
//   final Color backgroundColor;
//   final Color foregroundColor;
//   final EdgeInsetsGeometry? padding;

//   const CustomButton({
//     super.key,
//     required this.onPressed,
//     this.text, // Optional text
//     this.icon = Icons.arrow_forward_sharp, // Default icon
//     required this.backgroundColor,
//     required this.foregroundColor,
//     this.padding,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPressed, // Handle button press
//       child: Container(
//         height: 54,
//         width: 300,
//         decoration: BoxDecoration(
//           color: backgroundColor,
//           borderRadius: BorderRadius.circular(30.0),
//         ),
//         padding: padding ??
//             const EdgeInsets.symmetric(
//               horizontal: 16.0,
//             ),
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             if (text != null)
//               Text(
//                 text!,
//                 style: TextStyle(
//                   color: foregroundColor,
//                   fontFamily: 'Jost',
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             Positioned(
//               right: 8.0,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: foregroundColor,
//                   shape: BoxShape.circle,
//                 ),
//                 padding: const EdgeInsets.all(6.0),
//                 child: Icon(
//                   icon,
//                   color: backgroundColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
