import 'package:flutter/material.dart';
import 'package:food_delivery/bbhh/user_database.dart';
import 'package:food_delivery/models/sign_up_body_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';

class ModifyUserPage extends StatefulWidget {
  final SignUpBody user;

  const ModifyUserPage({Key? key, required this.user}) : super(key: key);

  @override
  _ModifyUserPageState createState() => _ModifyUserPageState();
}

class _ModifyUserPageState extends State<ModifyUserPage> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _phoneController = TextEditingController(text: widget.user.phone);
    _emailController = TextEditingController(text: widget.user.email);
    _passwordController = TextEditingController(text: widget.user.password);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _updateUser() async {
    final updatedUser = SignUpBody(
      id: widget.user.id,
      name: _nameController.text,
      phone: _phoneController.text,
      email: _emailController.text,
      password: _passwordController.text,
      role: widget.user.role, // El rol no se modifica
    );

    await UserDatabase.instance.updateUser(updatedUser);
    Navigator.pop(context); // Regresar a la página anterior
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFDF6),
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Modificar Usuario",
          size: 24,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.height20),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.height10),
              ),
            ),
            SizedBox(height: Dimensions.height20),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Teléfono',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.height10),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: Dimensions.height20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.height10),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: Dimensions.height20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.height10),
              ),
              obscureText: true,
            ),
            SizedBox(height: Dimensions.height30),
            ElevatedButton(
              onPressed: _updateUser,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainColor,
                padding: EdgeInsets.symmetric(vertical: Dimensions.height15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: BigText(text: 'Guardar Cambios', color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
