// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shopping_app/home/components/section_title.dart';
// import 'package:shopping_app/shimmer/shimmer.dart';
// import '../../allProducts/all_products.dart';
// import '../../models/p_products.dart';
// import '../../product_detail/products.dart';
//
// class PopularProducts extends StatefulWidget {
//   const PopularProducts({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<PopularProducts> createState() => _PopularProductsState();
// }
//
// class _PopularProductsState extends State<PopularProducts> {
//   bool _isFavorite = false;
//
//   late bool _isLoading;
//
//   @override
//   void initState() {
//     _isLoading = true;
//     Future.delayed(const Duration(seconds: 3), () {
//       setState(() {
//         _isLoading = false;
//       });
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('Products').limit(4).snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           // return const CircularProgressIndicator();
//         }
//         var products = snapshot.data!.docs.map((doc) {
//           return ProductModel.fromDocumentSnapshot(doc);
//         }).toList();
//
//         return Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: SectionTitle(
//                 title: 'Popular Products',
//                 press: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const AllProducts(),
//                       ));
//                 },
//               ),
//             ),
//             _isLoading
//                 ? Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: GridView.builder(
//                       shrinkWrap: true,
//                       itemCount: products.length,
//                       // scrollDirection: Axis.horizontal,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 15,
//                         childAspectRatio: 2 / 3.4,
//                         mainAxisSpacing: 15,
//                       ),
//                       itemBuilder: (context, index) {
//                         return const ContainerShimmer(
//                           height: 100,
//                           width: double.infinity,
//                           radius: 20,
//                         );
//                       },
//                     ),
//                   )
//                 : Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: GridView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: products.length,
//                       itemBuilder: (context, index) {
//                         var product = products[index];
//
//                         bool isFavorite =
//                             true; // Use a variable to track the favorite state
//
//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => ProductDetailsScreen(
//                                   product: product,
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Stack(
//                             children: [
//                               Container(
//                                 decoration: const BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(15.0),
//                                     topRight: Radius.circular(15.0),
//                                   ),
//                                 ),
//                                 child: Image.network(
//                                   product.images.isNotEmpty
//                                       ? product.images[0]
//                                       : 'https://example.com/default-image.jpg',
//                                   height: 155.0,
//                                   width: double.infinity,
//                                   fit: BoxFit.contain,
//                                 ),
//                               ),
//                               Positioned(
//                                 top: 10,
//                                 right: 10,
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: Colors.white,
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.grey.withOpacity(0.5),
//                                         spreadRadius: 2,
//                                         blurRadius: 5,
//                                         offset: const Offset(0, 2),
//                                       ),
//                                     ],
//                                   ),
//                                   child: IconButton(
//                                     icon: Icon(
//                                       _isFavorite
//                                           ? Icons.favorite
//                                           : Icons.favorite_border,
//                                       color: Colors.red,
//                                       size: 20,
//                                     ),
//                                     onPressed: () {
//                                       setState(() {
//                                         _isFavorite = !_isFavorite;
//                                       });
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                 bottom: 30,
//                                 left: 0,
//                                 right: 0,
//                                 child: Container(
//                                   padding: const EdgeInsets.all(8.0),
//                                   decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.only(
//                                       bottomRight: Radius.circular(15.0),
//                                       bottomLeft: Radius.circular(15.0),
//                                     ),
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(product.productName,
//                                           maxLines: 1,
//                                           overflow: TextOverflow.ellipsis,
//                                           style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
//                                       const SizedBox(height: 4.0),
//                                       Text(
//                                         product.productTitle,
//                                         style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 14,
//                                         )),
//                                         maxLines: 2,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       const SizedBox(height: 8.0),
//                                       Text('₹${product.productPrice}',
//                                           style: GoogleFonts.nunitoSans(
//                                               textStyle: const TextStyle(
//                                                   fontSize: 15,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.red))),
//                                       const SizedBox(
//                                         height: 10,
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 15,
//                         childAspectRatio: 2 / 3.4,
//                         // mainAxisSpacing: 15,
//                       ),
//                     ),
//                 ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/home/components/section_title.dart';
import 'package:shopping_app/allProducts/all_products.dart';
import 'package:shopping_app/models/p_products.dart';
import 'package:shopping_app/product_detail/products.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({
    Key? key,
  }) : super(key: key);

  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Products').limit(4).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return const Text('No data available');
        } else {
          var products = snapshot.data!.docs.map((doc) {
            return ProductModel.fromDocumentSnapshot(doc);
          }).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SectionTitle(
                  title: 'Popular Products',
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllProducts(),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    var product = products[index];

                    // bool isFavorite = true; // Use a variable to track the favorite state

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsScreen(
                              product: product,
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0),
                              ),
                            ),
                            child: Image.network(
                              product.images.isNotEmpty
                                  ? product.images[0]
                                  : 'https://example.com/default-image.jpg',
                              height: 155.0,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Positioned(
                            bottom: 30,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15.0),
                                  bottomLeft: Radius.circular(15.0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.productName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.nunitoSans(
                                      textStyle: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    product.productTitle,
                                    style: GoogleFonts.nunitoSans(
                                      textStyle: const TextStyle(fontSize: 14),
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    '₹${product.productPrice}',
                                    style: GoogleFonts.nunitoSans(
                                      textStyle: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    childAspectRatio: 2 / 3.4,
                    // mainAxisSpacing: 15,
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
