import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../address/widgets/single_address.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int currentStep = 0;
  List<String> stepTitles = ['Order Summary', 'Address', 'Payment'];
  late String selectedAddressId;

  @override
  void initState() {
    super.initState();
    selectedAddressId = '';
  }

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

  void setSelectedAddressId(String addressId) {
    setState(() {
      selectedAddressId = addressId;
    });
  }

  Widget controlBuilders(context, details) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            child: OutlinedButton(
              onPressed: details.onStepCancel,
              child: Text('Back',
                  style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: 150,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(

              ),
              onPressed: details.onStepContinue,
              child: Text(
                'Next',
                style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(stepTitles[currentStep],
            style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
      ),
      body: Stepper(
        controlsBuilder: controlBuilders,
        type: StepperType.horizontal,
        physics: const ScrollPhysics(),
        onStepTapped: onStepTapped,
        onStepContinue: continueStep,
        onStepCancel: cancelStep,
        currentStep: currentStep,
        connectorColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.green; // Color when pressed
            }
            return Colors.green; // Default color
          },
        ),
        steps: [
          Step(
            title: Text('Order Summary', style: GoogleFonts.nunitoSans()),
            content: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 130,
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.grey,
                      // width: 2.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Row(
                      children: [
                        Container(
                          height: 85,
                          width: 85,
                          decoration: BoxDecoration(
                            // color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(15)

                          ),
                          child: Center(child: Image.asset('assets/images/nike-shoes.png', fit: BoxFit.contain, height: 65, width: 65,)),
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Green Nike Sport Shoe', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.bold),),
                            Text('Size : 30 UK', style: GoogleFonts.nunitoSans(fontSize: 15, ),),
                            Text('Sale Price : 300', style: GoogleFonts.nunitoSans(fontSize: 15, ),),
                            Text('20% Off', style: GoogleFonts.nunitoSans(fontSize: 15, ),),
                            Text('Quantity : 1', style: GoogleFonts.nunitoSans(fontSize: 15,),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Text('Price Details', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.bold),),
                const Divider(thickness: 1,),
                const SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Price :', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.bold),),
                    Text('300', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.bold),),
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Discount :', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.bold),),
                    Text('-50', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.bold),),
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Delivery Charges :', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.bold),),
                    Text('35', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.bold),),
                  ],
                ),
                const SizedBox(height: 5,),
                const Divider(thickness: 1,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Amount :', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.bold),),
                    Text('285', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.bold),),
                  ],
                ),
                const Divider(thickness: 1,),
                const SizedBox(height: 10,),

              ],
            ),
            isActive: currentStep >= 0,
            state: currentStep >= 0 ? StepState.complete : StepState.disabled,
          ),
          Step(
            title: Text('Address', style: GoogleFonts.nunitoSans()),
            content: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Addresses')
                  .doc(user!.email) // Get addresses specific to the user's email
                  .collection('addresses')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    // child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (snapshot.hasData) {
                  final addresses = snapshot.data!.docs;
                  if (addresses.isEmpty) {
                    return Center(
                      child: Text(
                        'No addresses found.',
                        style: GoogleFonts.nunitoSans(),
                      ),
                    );
                  }
                  return Column(
                    children: addresses.map<Widget>((address) {
                      final data = address.data() as Map<String, dynamic>;
                      final addressId = address.id;
                      return RadioListTile<String>(
                        title: TSingleAddress(addressData: data),
                        value: addressId,
                        groupValue: selectedAddressId,
                        onChanged: (value) {
                          setSelectedAddressId(value!);
                        },
                      );
                    }).toList(),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
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
