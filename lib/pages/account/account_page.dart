import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/bbhh/user_database.dart';
import 'package:food_delivery/models/sign_up_body_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/account_widget.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';


class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables para almacenar los datos del usuario
    // String name ;
    // String phone ;
    // String email ;
    // String address ;

    // Future<void> fetchUserData() async {
    //   final List<SignUpBody> users = await UserDatabase.instance.readAllUsers();
    //   if (users.isNotEmpty) {
    //     final user = users.first;
    //     name = user.name;
    //     phone = user.phone;
    //     email = user.email;

    //   }
    // }
    return Scaffold(
      backgroundColor: Color(0xFFFFFDF6), 
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Perfil", size: 24, color:Colors.white,
        )
      ),
      body: Container(
        width: double.maxFinite,
        margin:EdgeInsets.only(top:Dimensions.height20*3),
        child: Column(
          children: [
            // profile icon
            AppIcon(icon: Icons.account_circle_outlined,
            backgroundColor: AppColors.paraColor,
            iconColor: Colors.white,
            iconSize: Dimensions.height45+Dimensions.height30*3,
            size: Dimensions.height15*10),
            SizedBox(height: Dimensions.height30*2,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // name
                    AccountWidget(
                      appIcon: AppIcon(icon: Icons.person,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: Dimensions.height10*5/2 ,
                        size: Dimensions.height10*5), 
                      bigText: BigText(text:"Ana Laura"),
                      ),
                      SizedBox(height: Dimensions.height20,),
                    // phone
                    AccountWidget(
                      appIcon: AppIcon(icon: Icons.phone,
                        backgroundColor:  Color.fromARGB(143, 46, 175, 63),
                        iconColor: Colors.white,
                        iconSize: Dimensions.height10*5/2 ,
                        size: Dimensions.height10*5), 
                      bigText: BigText(text:"11 7367 9577"),
                      ),
                      SizedBox(height: Dimensions.height20,),
                    // email
                    AccountWidget(
                      appIcon: AppIcon(icon: Icons.email,
                        backgroundColor: AppColors.yellowColor,
                        iconColor: Colors.white,
                        iconSize: Dimensions.height10*5/2 ,
                        size: Dimensions.height10*5), 
                      bigText: BigText(text:"analauragarcia.al@gmail.com"),
                      ),
                      SizedBox(height: Dimensions.height20,),
                    // adress
                    AccountWidget(
                      appIcon: AppIcon(icon: Icons.location_on,
                        backgroundColor: Color.fromARGB(96, 7, 103, 247),
                        iconColor: Colors.white,
                        iconSize: Dimensions.height10*5/2 ,
                        size: Dimensions.height10*5), 
                      bigText: BigText(text:"Buenos Aires, Argentina"),
                      ),
                      SizedBox(height: Dimensions.height20,),
                    // // message
                    // AccountWidget(
                    //   appIcon: AppIcon(icon: Icons.message_outlined,
                    //     backgroundColor: Colors.redAccent,
                    //     iconColor: Colors.white,
                    //     iconSize: Dimensions.height10*5/2 ,
                    //     size: Dimensions.height10*5), 
                    //   bigText: BigText(text:"?"),
                    //   ),
                    //   SizedBox(height: Dimensions.height20,),
                    //   AccountWidget(
                    //   appIcon: AppIcon(icon: Icons.message_outlined,
                    //     backgroundColor: Colors.redAccent,
                    //     iconColor: Colors.white,
                    //     iconSize: Dimensions.height10*5/2 ,
                    //     size: Dimensions.height10*5), 
                    //   bigText: BigText(text:"?"),
                    //   ),
                    //   SizedBox(height: Dimensions.height20,),
                  ],),
              ),
            )
            
          ],),
      )
    );
  }
}