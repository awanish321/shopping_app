// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class CheckoutScreen extends StatefulWidget {
//   const CheckoutScreen({super.key});
//
//   @override
//   State<CheckoutScreen> createState() => _CheckoutScreenState();
// }
//
// class _CheckoutScreenState extends State<CheckoutScreen> {
//
//   void incrementCounterForItem(DocumentSnapshot<Object?> item) {
//     setState(() {
//       int currentQuantity = item['quantity'] ?? 1;
//       currentQuantity++;
//       FirebaseFirestore.instance.collection('Cart').doc(FirebaseAuth.instance.currentUser!.email).collection('items').doc(item.id).update({
//         'quantity': currentQuantity,
//       });
//     });
//   }
//
//   void decrementCounterForItem(DocumentSnapshot<Object?> item) {
//     setState(() {
//       int currentQuantity = item['quantity'] ?? 1;
//       if (currentQuantity > 1) {
//         currentQuantity--;
//         FirebaseFirestore.instance.collection('Cart').doc(FirebaseAuth.instance.currentUser!.email).collection('items').doc(item.id).update({
//           'quantity': currentQuantity,
//         });
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Checkout', style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance.collection('Cart').doc(FirebaseAuth.instance.currentUser!.email).collection('items').snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const CircularProgressIndicator();
//                 }
//
//                 if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 }
//
//                 if (snapshot.data?.docs.isEmpty ?? true) {
//                 }
//
//                 var items = snapshot.data!.docs;
//
//                 return ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: items.length,
//                   itemBuilder: (context, index) {
//                     var item = items[index];
//
//                     return Container(
//                       width: double.infinity,
//                       height: 120,
//                       decoration: BoxDecoration(
//                         // color: Colors.white,
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
//                           child:
//                               Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Image.network(
//                                       item['image'],
//                                       height: 80,
//                                       width: 80,
//                                     ),
//                                     const SizedBox(width: 15),
//                                     Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Flexible(
//                                           child: Text(
//                                             item['productName'],
//                                             maxLines: 2 ,
//                                             style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//                                           ),
//                                         ),
//                                         const SizedBox(height: 5),
//                                         if (item['size'] != null && item['size'].isNotEmpty)
//                                           Flexible(
//                                             child: Text(
//                                               'Size: ${item['size']}',
//                                               style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold)),
//                                             ),
//                                           ),
//                                         const SizedBox(height: 5),
//                                         Flexible(
//                                           child: Text(
//                                             'Color: ${item['color']}',
//                                             style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold)),
//                                           ),
//                                         ),
//                                         const SizedBox(height: 8),
//                                         Text(
//                                           'Price: ₹${item['salePrice']}',
//                                           style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//                                         ),
//                                       ],
//                                     ),
//                                   ]
//                               ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
//

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int currentStep = 0;
  List<String> stepTitles = ['Order Summary', 'Address', 'Payment'];

  continueStep() {
    if (currentStep < 2) {
      setState(() {
        currentStep = currentStep + 1;
      });
    }
  }

  cancelStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep = currentStep - 1;
      });
    }
  }

  onStepTapped(int value) {
    setState(() {
      currentStep = value;
    });
  }

  Widget controlBuilders(context, details) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: details.onStepContinue,
            child: Text('Next', style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),),
          ),
          const SizedBox(width: 10),
          OutlinedButton(
            onPressed: details.onStepCancel,
            child: Text('Back', style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(stepTitles[currentStep], style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
      ),
      body: Stepper(
        elevation: 0, //Horizontal Impact
        controlsBuilder: controlBuilders,
        type: StepperType.horizontal,
        physics: const ScrollPhysics(),
        onStepTapped: onStepTapped,
        onStepContinue: continueStep,
        onStepCancel: cancelStep,
        currentStep: currentStep,
        steps: [
          Step(
              title: Text('Order Summary', style: GoogleFonts.nunitoSans()),
              content: const Column(
                children: [
                  Text('This is the first step.'),
                ],
              ),
              isActive: currentStep >= 0,
              state:
              currentStep >= 0 ? StepState.complete : StepState.disabled),
          Step(
            title: Text('Address', style: GoogleFonts.nunitoSans()),
            content: const Text('This is the Second step.'),
            isActive: currentStep >= 0,
            state: currentStep >= 1 ? StepState.complete : StepState.disabled,
          ),
          Step(
            title: Text('Payment', style: GoogleFonts.nunitoSans()),
            content: const Text('This is the Third step.'),
            isActive: currentStep >= 0,
            state: currentStep >= 2 ? StepState.complete : StepState.disabled,
          ),
        ],
      ),
    );
  }
}
