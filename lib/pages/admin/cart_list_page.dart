import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/no_data_page.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartListPage extends StatelessWidget {
  const CartListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();

    Map<String, int> cartItemsPerOrder = {};

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderTimeToList();
    var listCounter = 0;

    Widget timeWidget(int index) {
      var outputDate = "";
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[index].time!);
        var outputFormat = DateFormat("dd/MM/yyyy hh:mm a");
        outputDate = outputFormat.format(parseDate);
      }
      return BigText(text: outputDate);
    }

    void _showDeleteConfirmationDialog(BuildContext context, String orderTime) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirmación de Eliminación'),
            content: Text('¿Estás seguro de que deseas eliminar este carrito?'),
            actions: [
              TextButton(
                child: Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop(); // Cierra el diálogo
                },
              ),
              TextButton(
                child: Text('Eliminar'),
                onPressed: () {
                  Get.find<CartController>().removeAllCarts(); // Llama al método de eliminación
                  Navigator.of(context).pop(); // Cierra el diálogo
                },
              ),
            ],
          );
        },
      ).then((_) {
        // Actualiza la vista después de eliminar el carrito
        Get.find<CartController>().updateCartHistory();
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF6),
      body: Column(
        children: [
          Container(
            height: Dimensions.height10 * 10,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Cart History", color: Colors.white),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: AppColors.mainColor,
                  backgroundColor: AppColors.yellowColor,
                ),
              ],
            ),
          ),
         Expanded(
          child: GetBuilder<CartController>(
            builder: (_cartController) {
              var cartHistoryList = _cartController.getCartHistoryList().reversed.toList();

              return cartHistoryList.isNotEmpty
                  ? Container(
                      margin: EdgeInsets.only(
                        top: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                      ),
                      child: MediaQuery.removePadding(
                        context: context,
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            for (int i = 0; i < itemsPerOrder.length; i++)
                              Container(
                                margin: EdgeInsets.only(bottom: Dimensions.height20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    timeWidget(i),
                                    SizedBox(height: Dimensions.height10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Wrap(
                                            direction: Axis.horizontal,
                                            children: List.generate(itemsPerOrder[i], (index) {
                                              if (listCounter < cartHistoryList.length) {
                                                var item = cartHistoryList[listCounter];
                                                listCounter++;
                                                return index < 3
                                                    ? Container(
                                                        height: Dimensions.height20 * 4,
                                                        width: Dimensions.height20 * 4,
                                                        margin: EdgeInsets.only(right: Dimensions.width10 / 2),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(Dimensions.radius15 / 2),
                                                          image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: AssetImage('assets/image/${item.img!}'),
                                                          ),
                                                        ),
                                                      )
                                                    : Container();
                                              } else {
                                                return Container();
                                              }
                                            }),
                                          ),
                                        ),
                                        SizedBox(width: Dimensions.width10),
                                        Container(
                                          height: Dimensions.height20 * 4,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              SmallText(text: "Total", color: AppColors.titleColor),
                                              BigText(text: itemsPerOrder[i].toString() + " Items", color: AppColors.titleColor),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    icon: Icon(Icons.edit, color: AppColors.mainColor),
                                                    onPressed: () {
                                                      var orderTime = cartOrderTimeToList();
                                                      Map<int, CartModel> moreOrder = {};
                                                      for (int j = 0; j < cartHistoryList.length; j++) {
                                                        if (cartHistoryList[j].time == orderTime[i]) {
                                                          moreOrder.putIfAbsent(
                                                            cartHistoryList[j].id!,
                                                            () => CartModel.fromJson(jsonDecode(jsonEncode(cartHistoryList[j]))),
                                                          );
                                                        }
                                                      }
                                                      Get.find<CartController>().setItems = moreOrder;
                                                      Get.find<CartController>().addToCartList();
                                                      Get.toNamed(RouteHelper.getCartPage());
                                                    },
                                                  ),
                                                  SizedBox(width: Dimensions.width10),
                                                  IconButton(
                                                    icon: Icon(Icons.delete, color: Colors.red),
                                                    onPressed: () {
                                                      var orderTime = cartOrderTimeToList()[i];
                                                      _showDeleteConfirmationDialog(context, orderTime);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: const Center(
                        child: NoDataPage(text: "No compraste nada todavía", imgPath: "assets/image/empty_box.png"),
                      ),
                    );
            },
          ),
         )
        ],
      ),
    );
  }
}
