import 'package:flutter/material.dart';
import 'package:food_delivery/bbhh/user_database.dart';
import 'package:food_delivery/models/sign_up_body_model.dart';
import 'package:food_delivery/pages/admin/modify_user_page.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List<SignUpBody> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final List<SignUpBody> allUsers = await UserDatabase.instance.getAllUsers();
    setState(() {
      users = allUsers;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFDF6),
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Usuarios",
          size: 24,
          color: Colors.white,
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  contentPadding: EdgeInsets.all(Dimensions.height10),
                  leading: Icon(
                    Icons.person,
                    color: AppColors.mainColor,
                  ),
                  title: BigText(text: user.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(text: 'Email: ${user.email}', size: Dimensions.font16),
                      BigText(text: 'Teléfono: ${user.phone}', size: Dimensions.font16),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: AppColors.mainColor),
                        onPressed: () async {
                          // Navega a la página de modificación y espera el resultado
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ModifyUserPage(user: user),
                            ),
                          );
                          // Actualiza la lista de usuarios después de regresar de ModifyUserPage
                          fetchUsers();
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          // Mostrar alerta de confirmación antes de eliminar
                          final confirmed = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Confirmar Eliminación'),
                              content: Text('¿Estás seguro de que quieres eliminar este usuario?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: Text('No'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: Text('Sí'),
                                ),
                              ],
                            ),
                          );

                          if (confirmed == true) {
                            await UserDatabase.instance.deleteUser(user.id!);
                            fetchUsers(); // Actualiza la lista de usuarios
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
