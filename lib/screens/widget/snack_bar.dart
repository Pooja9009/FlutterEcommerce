import 'package:flutter/material.dart';

showSnackbar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      // action: SnackBarAction(
      //   label: 'dismiss',
      //   onPressed: () {},
      // ),
    ),
  );
}



// class SnackBar {
  
//   showTopSnackBar(BuildContext context) {
//     Flushbar(
//       icon: const Icon(Icons.error, size: 32, color: Colors.white),
//       shouldIconPulse: false,
//       title: 'Title',
//       message: 'Hello',
//       // mainButton: FlatButton(
//       //   child: const Text(
//       //     'Click Me',
//       //     style: TextStyle(color: Colors.white, fontSize: 16),
//       //   ),
//       //   onPressed: () {},
//       // ),
//       // onTap: (_) {
//       //   print('Clicked bar');
//       // },
//       duration: const Duration(seconds: 3),
//       flushbarPosition: FlushbarPosition.TOP,
//       margin: const EdgeInsets.fromLTRB(8, kToolbarHeight + 8, 8, 0),
//       borderRadius: 16,
//     );
//   }

//   // void showBlurredSnackBar(BuildContext context) => show(
//   //       context,
//   //       Flushbar(
//   //         icon: const Icon(Icons.error, size: 32, color: Colors.white),
//   //         shouldIconPulse: false,
//   //         title: 'Title',
//   //         message: 'Hello',
//   //         // mainButton: FlatButton(
//   //         //   child: const Text(
//   //         //     'Click Me',
//   //         //     style: TextStyle(color: Colors.white, fontSize: 16),
//   //         //   ),
//   //         //   onPressed: () {},
//   //         // ),
//   //         onTap: (_) {
//   //           print('Clicked bar');
//   //         },
//   //         padding: const EdgeInsets.all(24),
//   //         flushbarPosition: FlushbarPosition.TOP,
//   //         margin: const EdgeInsets.fromLTRB(8, kToolbarHeight + 8, 8, 0),
//   //         duration: const Duration(seconds: 3),
//   //         borderRadius: 16,
//   //         barBlur: 20,
//   //         backgroundColor: Colors.black.withOpacity(0.5),
//   //       ),
//   //     );

//   // void showDismissSnackBar(BuildContext context) => show(
//   //       context,
//   //       Flushbar(
//   //         icon: const Icon(Icons.error, size: 32, color: Colors.white),
//   //         shouldIconPulse: false,
//   //         title: 'Title',
//   //         message: 'Hello',
//   //         mainButton: FlatButton(
//   //           child: const Text(
//   //             'Click Me',
//   //             style: TextStyle(color: Colors.white, fontSize: 16),
//   //           ),
//   //           onPressed: () {},
//   //         ),
//   //         onTap: (_) {
//   //           print('Clicked bar');
//   //         },
//   //         flushbarPosition: FlushbarPosition.TOP,
//   //         margin: const EdgeInsets.fromLTRB(8, kToolbarHeight + 8, 8, 0),
//   //         borderRadius: 16,
//   //         backgroundColor: Colors.blue.withOpacity(0.7),
//   //         barBlur: 20,
//   //         padding: const EdgeInsets.all(24),
//   //         animationDuration: const Duration(microseconds: 0),
//   //         dismissDirection: FlushbarDismissDirection.HORIZONTAL,
//   //       ),
//   //     );

//   // void showGradientSnackBar(BuildContext context) => show(
//   //       context,
//   //       Flushbar(
//   //         animationDuration: const Duration(microseconds: 0),
//   //         icon: const Icon(Icons.error, size: 32, color: Colors.white),
//   //         shouldIconPulse: false,
//   //         title: 'Title',
//   //         message: 'Hello',
//   //         mainButton: FlatButton(
//   //           child: const Text(
//   //             'Click Me',
//   //             style: TextStyle(color: Colors.white, fontSize: 16),
//   //           ),
//   //           onPressed: () {},
//   //         ),
//   //         padding: const EdgeInsets.all(24),
//   //         flushbarPosition: FlushbarPosition.TOP,
//   //         margin: const EdgeInsets.fromLTRB(8, kToolbarHeight + 8, 8, 0),
//   //         duration: const Duration(seconds: 3),
//   //         borderRadius: 16,
//   //         backgroundGradient: const LinearGradient(
//   //           colors: [Colors.red, Colors.orange],
//   //         ),
//   //         boxShadows: const [
//   //           BoxShadow(
//   //             color: Colors.red,
//   //             offset: Offset(2, 2),
//   //             blurRadius: 8,
//   //           )
//   //         ],
//   //       ),
//   //     );
// }
