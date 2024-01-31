// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:shopping_app/cart/cart.dart';
// import 'package:shopping_app/home/components/store.dart';
// import 'package:shopping_app/home/components/wishlist.dart';
// import 'package:shopping_app/home/home_screen.dart';
// import 'package:shopping_app/screens/profile/profile_screen.dart';
//
// import '../../models/p_products.dart';
//
// class MyBottomNavBar extends StatefulWidget {
//   const MyBottomNavBar({Key? key}) : super(key: key);
//
//   @override
//   State<MyBottomNavBar> createState() => _MyBottomNavBarState();
// }
//
// class _MyBottomNavBarState extends State<MyBottomNavBar> {
//   final List<ProductModel> _wishlistProducts = [];
//   int myCurrentIndex = 0;
//   List pages = [
//     const HomeScreen(),
//     const CartScreen(),
//     WishlistScreen(wishlistProducts: _wishlistProducts),
//     const ProfileScreen()
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey,
//       extendBody: true,
//       bottomNavigationBar: SizedBox(
//         height: 70, // Set the desired height
//         child: ClipRRect(
//           borderRadius: const BorderRadius.only(
//             topRight: Radius.circular(20),
//             topLeft: Radius.circular(20),
//           ),
//           child: BottomNavigationBar(
//             type: BottomNavigationBarType.fixed,
//             selectedItemColor: Colors.redAccent,
//             unselectedItemColor: Colors.black,
//             selectedLabelStyle: GoogleFonts.nunitoSans() ,
//             unselectedLabelStyle: GoogleFonts.nunitoSans(),
//
//             currentIndex: myCurrentIndex,
//             onTap: (index) {
//               setState(() {
//                 myCurrentIndex = index;
//               });
//             },
//             selectedFontSize: 13,
//             unselectedFontSize: 13,
//             items: const [
//               BottomNavigationBarItem(
//                 icon: Icon(Iconsax.home),
//                 label: "Home",
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Iconsax.shopping_cart),
//                 label: "Cart",
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Iconsax.heart),
//                 label: "Wishlist",
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Iconsax.user),
//                 label: "Profile",
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: pages[myCurrentIndex],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_app/home/components/store.dart';
import 'package:shopping_app/home/components/wishlist.dart';
import 'package:shopping_app/home/home_screen.dart';
import 'package:shopping_app/screens/profile/profile_screen.dart';

import '../../models/p_products.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({Key? key}) : super(key: key);

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int myCurrentIndex = 0;
  late List pages;

  @override
  Widget build(BuildContext context) {
    List<ProductModel> wishlistProducts = [];

    pages = [
      const HomeScreen(),
      const Store(),
      const WishlistScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFF8A80),
      extendBody: true,
      bottomNavigationBar: SizedBox(
        height: 70,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.redAccent,
            unselectedItemColor: Colors.black,
            selectedLabelStyle: GoogleFonts.nunitoSans(),
            unselectedLabelStyle: GoogleFonts.nunitoSans(),
            currentIndex: myCurrentIndex,
            onTap: (index) {
              setState(() {
                myCurrentIndex = index;
              });
            },
            selectedFontSize: 13,
            unselectedFontSize: 13,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Iconsax.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.shopping_bag),
                label: "Order",
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.heart),
                label: "Wishlist",
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.user),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
      body: pages[myCurrentIndex],
    );
  }
}
