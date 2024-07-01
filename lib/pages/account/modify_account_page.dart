import 'package:flutter/material.dart';
import 'package:food_delivery/bbhh/preferences_service.dart';
import 'package:food_delivery/bbhh/user_database.dart';
import 'package:food_delivery/models/sign_up_body_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';

class ModifyAccountPage extends StatefulWidget {
  const ModifyAccountPage({Key? key}) : super(key: key);

  @override
  _ModifyAccountPageState createState() => _ModifyAccountPageState();
}

class _ModifyAccountPageState extends State<ModifyAccountPage> {
  late String name;
  late String phone;
  late String email;
  late String password;

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
          password = user.password;
          isLoading = false;
        });
      } else {
        // Handle case where user is not found
        setState(() {
          isLoading = false;
        });
      }
    } else {
      // Handle case where no user is logged in
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
          text: "Modificar Perfil",
          size: 24,
          color: Colors.white,
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(Dimensions.width20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Profile icon
                  Center(
                    child: AppIcon(
                      icon: Icons.account_circle_outlined,
                      backgroundColor: AppColors.paraColor,
                      iconColor: Colors.white,
                      iconSize: Dimensions.height45 + Dimensions.height30 * 3,
                      size: Dimensions.height15 * 10,
                    ),
                  ),
                  SizedBox(height: Dimensions.height30 * 2),
                  // Name input
                  TextFormField(
                    initialValue: name,
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: Dimensions.height20),
                  // Phone input
                  TextFormField(
                    initialValue: phone,
                    onChanged: (value) {
                      setState(() {
                        phone = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Teléfono',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: Dimensions.height20),
                  // Email input
                  TextFormField(
                    initialValue: email,
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: Dimensions.height20),
                  // Password input (for demonstration purposes, showing password)
                  TextFormField(
                    initialValue: password,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: Dimensions.height20),
                  // Save button
                  ElevatedButton(
                    onPressed: () {
                      // Save changes method
                      saveChanges(context);
                    },
                    child: BigText(text: "Guardar Cambios", color: Colors.white),
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

  void saveChanges(BuildContext context) async {
    // Save changes to the database
    final PreferencesService preferencesService = PreferencesService();
    final int? userId = await preferencesService.getUserId();

    if (userId != null) {
      final SignUpBody user = SignUpBody(
        id: userId,
        name: name,
        phone: phone,
        email: email,
        password: password,
      );

      await UserDatabase.instance.updateUser(user);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cambios guardados')),
      );

      // Example: Navigate back to previous page and pass updated data
      Navigator.pop(context, user);
    }
  }
}
