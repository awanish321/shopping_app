import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});


  // Define the showAlertDialog function here
  void showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel", style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),),
      onPressed: () {},
    );
    Widget continueButton = TextButton(
      child: Text("Continue", style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500)),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      contentPadding: const EdgeInsets.all(15),
      title: Text("Delete Account", style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),),
      content: Text("Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.", style: GoogleFonts.nunitoSans(fontSize: 15), textAlign: TextAlign.center,),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Center(child: CircleAvatar(radius: 40,child: Image.asset('assets/images/Profile Image.png', ),)),
                  TextButton(onPressed: (){}, child: Text('Change Profile Picture', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500,),))
                ],
              ),
              const Divider(),
              const SizedBox(height: 10,),
              Text('Profile Information', style: GoogleFonts.nunitoSans(fontSize: 20, fontWeight: FontWeight.bold),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex: 3,child: Text('Name', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),)),
                  Expanded(flex: 5, child: Text('Awanish Chaurasiya', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),)),
                  IconButton(onPressed: (){}, icon: const Icon(Iconsax.arrow_right_3))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex: 3, child: Text('UserName', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),)),
                  Expanded(flex: 5, child: Text('@awanish', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),)),
                  IconButton(onPressed: (){}, icon: const Icon(Iconsax.arrow_right_3))
                ],
              ),
              const SizedBox(height: 10,),
              const Divider(),
              const SizedBox(height: 10,),
              Text('Personal Information', style: GoogleFonts.nunitoSans(fontSize: 20, fontWeight: FontWeight.bold),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex: 3, child: Text('User Id', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),)),
                  Expanded(flex: 5, child: Text('0qFvkr1nA3afoN7o559vsND5VYD3', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis,)),
                  IconButton(onPressed: (){}, icon: const Icon(Iconsax.copy))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex: 3, child: Text('E-Mail', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),)),
                  Expanded(flex: 5, child: Text('awanishchaurasiya89@gmail.com', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,)),
                  IconButton(onPressed: (){}, icon: const Icon(Iconsax.arrow_right_3))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex: 3, child: Text('Phone Number', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),)),
                  Expanded(flex: 5, child: Text('(+91) 8824682311', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),)),
                  IconButton(onPressed: (){}, icon: const Icon(Iconsax.arrow_right_3))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex: 3, child: Text('Gender', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),)),
                  Expanded(flex: 5, child: Text('Male', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),)),
                  IconButton(onPressed: (){}, icon: const Icon(Iconsax.arrow_right_3))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex: 3, child: Text('Date Of Birth', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),)),
                  Expanded(flex: 5, child: Text('2 February 2000', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),)),
                  IconButton(onPressed: (){}, icon: const Icon(Iconsax.arrow_right_3))
                ],
              ),
              const Divider(),
              const SizedBox(height: 15,),
              Center(child: TextButton(onPressed: (){showAlertDialog(context);}, child: Text('Close Account', style: GoogleFonts.nunitoSans(fontSize: 15, color: Colors.red),)))
            ],
          ),
        ),
      ),
    );
  }
}
