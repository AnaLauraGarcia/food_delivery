
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/bbhh/user_database.dart';
import 'package:food_delivery/pages/auth/sign_in_page.dart';
import 'package:food_delivery/pages/home/home_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/models/sign_up_body_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';


class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = ["f.png", "g.png", "x.png"];

    void _registration() async {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();



      if (email.isEmpty) {
        showCustomSnackBar("Ingresa tu email", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Ingresa un email en formato ejemplo@dominio.com", title: "Email inválido");
      } else if (password.isEmpty) {
        showCustomSnackBar("Ingresa tu contraseña", title: "Contraseña");
      } else if (password.length < 6) {
        showCustomSnackBar("La contraseña debe tener como mínimo seis caracteres", title: "Contraseña inválida");
      } else if (name.isEmpty) {
        showCustomSnackBar("Ingresa tu nombre", title: "Nombre");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Ingresa tu nº de teléfono", title: "Teléfono");
      } else {
        SignUpBody signUpBody = SignUpBody(
          name: name,
          phone: phone,
          email: email,
          password: password,
        );

        // Insertar el usuario en la base de datos
        await UserDatabase.instance.createUser(signUpBody);
        showCustomSnackBar("Usuario registrado exitosamente", title: "Éxito", isError: false);

        Get.to(HomePage());
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
                  backgroundImage: AssetImage("assets/image/logo.png"),
                ),
              ),
            ),
            // your email
            AppTextField(
              textController: emailController,
              hintText: "Email",
              icon: Icons.email,
            ),
            SizedBox(height: Dimensions.height20),
            // your password
            AppTextField(
              textController: passwordController,
              hintText: "Contraseña",
              icon: Icons.password_sharp,
            ),
            SizedBox(height: Dimensions.height20),
            // your name
            AppTextField(
              textController: nameController,
              hintText: "Nombre",
              icon: Icons.person,
            ),
            SizedBox(height: Dimensions.height20),
            // your phone
            AppTextField(
              textController: phoneController,
              hintText: "Teléfono",
              icon: Icons.phone,
            ),
            SizedBox(height: Dimensions.height20),
            GestureDetector(
              onTap: _registration,
              child: Container(
                width: Dimensions.screenWidth / 2,
                height: Dimensions.screenHeight / 13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: AppColors.mainColor,
                ),
                child: Center(
                  child: BigText(
                    text: "Sign up",
                    size: Dimensions.font20 + Dimensions.font20 / 2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: Dimensions.height10),
            RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()..onTap = () => Get.to(()=>SignInPage(), transition: Transition.fade),
                text: "Ya tenés una cuenta?",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font16,
                ),
              ),
            ),
            SizedBox(height: Dimensions.screenHeight * 0.05),
            RichText(
              text: TextSpan(
                text: "Registrate con tus redes sociales",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font16,
                ),
              ),
            ),
            SizedBox(height: Dimensions.height20),
            Wrap(
              children: List.generate(3, (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Color(0xFFFFFDF6),
                  radius: Dimensions.radius20,
                  backgroundImage: AssetImage("assets/image/" + signUpImages[index]),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
