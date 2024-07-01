import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/bbhh/user_database.dart';
import 'package:food_delivery/pages/home/home_page.dart';
import 'package:food_delivery/pages/splash/splash_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';


class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login() async {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        showCustomSnackBar("Ingresa tu email", title: "Email");
      } else if (password.isEmpty) {
        showCustomSnackBar("Ingresa tu contraseña", title: "Contraseña");
      } else {
        bool isLoggedIn = await UserDatabase.instance.loginUser(email, password);


        if (isLoggedIn) {
          // Navegar a la pantalla de inicio o realizar la acción deseada cuando el inicio de sesión sea exitoso
          //showCustomSnackBar("Inicio de sesión exitoso", title: "Éxito", isError: false);
          
          Get.to(HomePage());
          await UserDatabase.instance.showDatabaseContents();

        } else {
          showCustomSnackBar("Credenciales incorrectas", title: "Error");
        }
      }
    }

    return Scaffold(
      backgroundColor: Color(0xFFFFFDF6),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: Dimensions.screenHeight * 0.05),
            // app logo
            Container(
              height: Dimensions.screenHeight * 0.25,
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Color(0xFFFFFDF6),
                  radius: 100,
                  backgroundImage: AssetImage(
                    "assets/image/logo.png",
                  ),
                ),
              ),
            ),
            // welcome
            Container(
              margin: EdgeInsets.only(left: Dimensions.width20),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hola",
                    style: TextStyle(
                      fontSize: Dimensions.font20 * 3 + Dimensions.font20 / 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                  children: [
                    Text(
                      "Inicia sesión en tu cuenta",
                        style: TextStyle(
        
                          fontSize: Dimensions.font20,
                          color: Colors.grey[500],
                        )
                      ),
                  ]
                ),
                  SizedBox(height: Dimensions.height20),
                  AppTextField(
                    textController: emailController,
                    hintText: "Email",
                    icon: Icons.email,
                  ),
                  SizedBox(height: Dimensions.height20),
                  AppTextField(
                    textController: passwordController,
                    hintText: "Contraseña",
                    icon: Icons.password_sharp,
                  ),
                  SizedBox(height: Dimensions.height20),
                  SizedBox(height: Dimensions.height20),
                  Center(
                    child: Container(
                      width: Dimensions.screenWidth / 2,
                      height: Dimensions.screenHeight / 13,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius30),
                        color: AppColors.mainColor,
                      ),
                      child: GestureDetector(
                        onTap: _login,
                        child: Center(
                          child: BigText(
                            text: "Sign in",
                            size: Dimensions.font20 + Dimensions.font20 / 2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.screenHeight * 0.05),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "¿No tenés cuenta? ",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font16,
                        ),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.to(() => SignUpPage(), transition: Transition.fade),
                            text: "Registrate",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainBlackColor,
                              fontSize: Dimensions.font20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.height20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:food_delivery/pages/auth/sign_up_page.dart';
// import 'package:food_delivery/utils/colors.dart';
// import 'package:food_delivery/utils/dimensions.dart';
// import 'package:food_delivery/widgets/app_text_field.dart';
// import 'package:food_delivery/widgets/big_text.dart';
// import 'package:get/get.dart';


// class SignInPage extends StatelessWidget {
//   const SignInPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var emailController = TextEditingController();
//     var passwordController = TextEditingController();
//     var nameController = TextEditingController();
//     var phoneController = TextEditingController();


//     return Scaffold(
//       backgroundColor: Color(0xFFFFFDF6), 
//       body: SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child: Column(

//           children: [
//             SizedBox(height: Dimensions.screenHeight*0.05,),
//             // app logo
//             Container(
//               height: Dimensions.screenHeight*0.25,
//               child: Center(
//                 child: CircleAvatar(
//                   backgroundColor: Color(0xFFFFFDF6), 
//                   radius: 100,
//                   backgroundImage:  AssetImage(
//                     "assets/image/logo.png",
//                   ),),
//               )
//               ),           
//             // welcome
//             Container(
//               margin: EdgeInsets.only(left: Dimensions.width20),
//               width: double.maxFinite,
//               child:Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Hola",
//                     style: TextStyle(
//                       fontSize: Dimensions.font20*3+Dimensions.font20/2,
//                       fontWeight: FontWeight.bold
//                     ),
//                   ),
//             Row(
//               children: [
//                 Text(
//                    "Inicia sesión en tu cuenta",
//                     style: TextStyle(
     
//                       fontSize: Dimensions.font20,
//                       color: Colors.grey[500],
//                     )
//                   ),
//               ]
//             ),

//             SizedBox(height: Dimensions.height20),

//             // your name
//             AppTextField(
//               textController: nameController, 
//               hintText: "Nombre", 
//               icon: Icons.person),
//             SizedBox(height: Dimensions.height20,),
//             // your password
//             AppTextField(
//               textController: passwordController, 
//               hintText: "Contraseña", 
//               icon: Icons.password_sharp),
//             SizedBox(height: Dimensions.height20,),
//             Row(
//               children: [
//                 Expanded(child: Container()),
//                 RichText(
//                   text: TextSpan(
//                     recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
//                     text: "Inicia sesión en tu cuenta",
//                     style: TextStyle(
//                       color: Colors.grey[500],
//                       fontSize: Dimensions.font16
//                     )
//                   ),
//                 ),
//                 SizedBox(width: Dimensions.width20,),
//               ]
//             ),
            
//             SizedBox(height: Dimensions.screenHeight*0.05,),
            
            
//             Center(
//               child: Container(
//                 width: Dimensions.screenWidth/2,
//                 height: Dimensions.screenHeight/13,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular (Dimensions.radius30),
//                   color: AppColors.mainColor
//                 ),
//                 child: Center(
//                   child: BigText(
//                     text: "Sign in",
//                     size: Dimensions.font20+Dimensions.font20/2,
//                     color: Colors.white,
                
//                   ),
//                 ),
//               ),
//             ),
            
//             SizedBox(height: Dimensions.screenHeight*0.05,),
//               Center(
//                 child: RichText(
//                   text: TextSpan(
//                     text: "¿No tenés cuenta? ",
//                     style: TextStyle(
//                       color: Colors.grey[500],
//                       fontSize: Dimensions.font16
//                     ),
//                     children: [
//                       TextSpan(
//                       recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(), transition: Transition.fade),
                        
//                     text: "Registrate",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.mainBlackColor,
//                       fontSize: Dimensions.font20
//                     )),
//                     ],
//                   ),),
//               ),
//                 SizedBox(height: Dimensions.height20),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }