import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/bbhh/preferences_service.dart';
import 'package:food_delivery/bbhh/user_database.dart';
import 'package:food_delivery/models/sign_up_body_model.dart';
import 'package:food_delivery/pages/account/modify_account_page.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/account_widget.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String name = '';
  String phone = '';
  String email = '';

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final PreferencesService preferencesService = PreferencesService();
    final int? userId = await preferencesService.getUserId();

    if (userId != null) {
      final SignUpBody? user = await UserDatabase.instance.readUser(userId);
      if (user != null) {
        setState(() {
          name = user.name;
          phone = user.phone;
          email = user.email;
          isLoading = false;
        });
      } else {
        // Si el usuario no se encuentra, puedes manejar esto adecuadamente aquí
        setState(() {
          isLoading = false;
        });
      }
    } else {
      // Si no hay usuario logueado, puedes manejar esto adecuadamente aquí
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFDF6),
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Perfil",
          size: 24,
          color: Colors.white,
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(top: Dimensions.height20 * 3),
                    child: Column(
                      children: [
                        // profile icon
                        AppIcon(
                          icon: Icons.account_circle_outlined,
                          backgroundColor: AppColors.paraColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height45 + Dimensions.height30 * 3,
                          size: Dimensions.height15 * 10,
                        ),
                        SizedBox(height: Dimensions.height30 * 2),
                        // name
                        AccountWidget(
                          appIcon: AppIcon(
                            icon: Icons.person,
                            backgroundColor: AppColors.mainColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10 * 5 / 2,
                            size: Dimensions.height10 * 5,
                          ),
                          bigText: BigText(text: name),
                        ),
                        SizedBox(height: Dimensions.height20),
                        // phone
                        AccountWidget(
                          appIcon: AppIcon(
                            icon: Icons.phone,
                            backgroundColor: Color.fromARGB(143, 46, 175, 63),
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10 * 5 / 2,
                            size: Dimensions.height10 * 5,
                          ),
                          bigText: BigText(text: phone),
                        ),
                        SizedBox(height: Dimensions.height20),
                        // email
                        AccountWidget(
                          appIcon: AppIcon(
                            icon: Icons.email,
                            backgroundColor: AppColors.yellowColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10 * 5 / 2,
                            size: Dimensions.height10 * 5,
                          ),
                          bigText: BigText(text: email),
                        ),
                        SizedBox(height: Dimensions.height20),
                        // adress
                        AccountWidget(
                          appIcon: AppIcon(
                            icon: Icons.location_on,
                            backgroundColor: Color.fromARGB(96, 7, 103, 247),
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10 * 5 / 2,
                            size: Dimensions.height10 * 5,
                          ),
                          bigText: BigText(text: "Buenos Aires, Argentina"),
                        ),
                        SizedBox(height: Dimensions.height10*2),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ModifyAccountPage()),
                      );

                      if (result != null && result is SignUpBody) {
                        // Actualizar los datos en AccountPage con los datos modificados
                        setState(() {
                          name = result.name;
                          phone = result.phone;
                          email = result.email;
                        });
                      }
                    },
                    child: BigText(text: "Modificar", color: Colors.white),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: Dimensions.height20, horizontal: Dimensions.height10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                      ),
                      backgroundColor: AppColors.mainColor,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
