import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/home/components/search_field.dart';
import 'package:shopping_app/models/user_model.dart';
import '../cart/cart.dart';
import 'components/categories.dart';
import 'components/icon_btn_with_counter.dart';
import 'components/popular_product.dart';
import 'components/special_offers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? _user; // Variable to hold the user data

  @override
  void initState() {
    super.initState();
    _getUserData(); // Fetch user data when the screen initializes
  }

  // Method to fetch user data from FireStore
  void _getUserData() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
    await FirebaseFirestore.instance.collection('User').doc(userId).get();
    setState(() {
      _user = UserModel.fromSnapshot(userSnapshot); // Update the user data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFF5F5F3),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good day for shopping',
                        style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      // Display the username fetched from FireStore if available, otherwise show 'Loading...'
                      Text(
                        _user != null ? _user!.name : 'Loading...',
                        style: GoogleFonts.nunitoSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      IconBtnWithCounter(
                        svgSrc: "assets/icons/Cart Icon.svg",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CartScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                      IconBtnWithCounter(
                        svgSrc: "assets/icons/Bell.svg",
                        numOfitem: 3,
                        press: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 0),
                    child: SearchField(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 55,
                    width: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFF979797).withOpacity(0.2),
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const FaIcon(FontAwesomeIcons.sliders, size: 20),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            const SpecialOffers(),
            const SizedBox(height: 20),
            const Categories(),
            const SizedBox(height: 20),
            const PopularProducts(),
          ],
        ),
      ),
    );
  }
}
