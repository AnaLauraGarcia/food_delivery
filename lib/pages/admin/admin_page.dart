import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/admin/cart_list_page.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:food_delivery/pages/admin/list_user_page.dart';
import 'package:food_delivery/pages/auth/sign_in_page.dart';
import 'package:food_delivery/bbhh/preferences_service.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late PersistentTabController _controller;
  final PreferencesService _preferencesService = PreferencesService(); // Instancia del servicio de preferencias

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      _buildAdminScreen(), 

      CartListPage(),
      UsersPage(),
      Container(), 
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Inicio"),
        activeColorPrimary: CupertinoColors.systemGrey,
        inactiveColorPrimary: AppColors.mainColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.archivebox_fill),
        title: ("Pedidos"),
        activeColorPrimary: CupertinoColors.systemGrey,
        inactiveColorPrimary: AppColors.mainColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person),
        title: ("Usuarios"),
        activeColorPrimary: CupertinoColors.systemGrey,
        inactiveColorPrimary: AppColors.mainColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.power),
        title: ("Deslogearte"),
        activeColorPrimary: CupertinoColors.systemGrey,
        inactiveColorPrimary: AppColors.mainColor,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Color(0xFFFFFDF6),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style3,
      onItemSelected: _handleNavBarSelection, // Maneja la selección de ítems
    );
  }

  Widget _buildAdminScreen() {
    return Scaffold(
      backgroundColor: Color(0xFFFFFDF6),
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "El buen sazón - Admin",
          size: 24,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.height20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigText(
                text: "Bienvenido, Admin",
                size: Dimensions.font26,
                color: AppColors.mainColor,
              ),
              SizedBox(height: Dimensions.height20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildQuickInfoCard("Pedidos Hoy", "95"),
                  _buildQuickInfoCard("Ingresos Hoy", "\$211.896"),
                ],
              ),
              SizedBox(height: Dimensions.height20),
              _buildSectionTitle("Estadísticas"),
              Image.asset('assets/image/estadistica.png'),
              SizedBox(height: Dimensions.height20),
              _buildSectionTitle("Tareas Pendientes"),
              _buildTaskList(["Revisar pedidos especiales", "Actualizar stock", "Responder mensajes"]),
              SizedBox(height: Dimensions.height20),
              _buildSectionTitle("Noticias y Actualizaciones"),
              _buildNewsList(["Actualización del sistema el 24/07", "Nueva política de reembolsos"]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickInfoCard(String title, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(Dimensions.height20),
        margin: EdgeInsets.symmetric(horizontal: Dimensions.width10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            BigText(text: value, size: Dimensions.font26, color: AppColors.mainColor),
            SizedBox(height: Dimensions.height10),
            Text(
              title,
              style: TextStyle(fontSize: Dimensions.font16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return BigText(
      text: title,
      size: Dimensions.font20,
      color: AppColors.mainColor,
    );
  }

  Widget _buildTaskList(List<String> tasks) {
    return Column(
      children: tasks.map((task) => ListTile(title: Text(task))).toList(),
    );
  }

  Widget _buildNewsList(List<String> news) {
    return Column(
      children: news.map((newsItem) => ListTile(title: Text(newsItem))).toList(),
    );
  }

  // Maneja la acción de deslogueo
  void _handleNavBarSelection(int index) {
    if (index == 3) { // Índice de "Deslogearte"
      _showLogoutConfirmationDialog();
    } else {
      setState(() {
        _controller.index = index;
      });
    }
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Cierre de Sesión'),
          content: Text('¿Estás seguro de que quieres cerrar sesión?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
            ),
            TextButton(
              child: Text('Sí'),
              onPressed: () async {
                Navigator.of(context).pop(); // Cierra el diálogo
                await _logout(); // Llama al método de cierre de sesión
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout() async {
    await _preferencesService.removeUserId(); // Elimina el ID del usuario
    Get.offAll(() => SignInPage()); // Redirige a la página de inicio de sesión
  }
}
