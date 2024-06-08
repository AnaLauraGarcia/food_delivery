import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';


class PopularFoodDetail extends StatelessWidget {
  const PopularFoodDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover, //Este es el que amplia la imagen gasta los bordes
                  image: AssetImage(
                    "assets/image/food1.png"
                  )
                ),
              ),
            ),
          ),
          //icon widgets
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  Get.to(()=>MainFoodPage());
                },
                child: 
              AppIcon(icon: Icons.arrow_back_ios)),
              AppIcon(icon: Icons.shopping_cart_outlined),
            ],
            ),
          ),
          //introduction of food
          Positioned(
            left:0,
            right: 0,
            bottom: 0,
            top:Dimensions.popularFoodImgSize-20,
            child: Container(
              padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20,top: Dimensions.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20) ,
                    topLeft: Radius.circular(Dimensions.radius20) ,
                  ),
                  color: Colors.white,
                  //color: Colors.redAccent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text:"Chinese Side"),
                    SizedBox(height: Dimensions.height20,),
                    BigText(text: "Introduce"),
                    SizedBox(height: Dimensions.height20,),
                    Expanded(child: SingleChildScrollView(child: ExpandableTextWidget(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Curabitur pretium tincidunt lacus. Nulla gravida orci a odio. Nullam varius, turpis et commodo pharetra, est eros bibendum elit. Suspendisse nec magna sit amet risus vehicula tincidunt. Proin justo purus, dignissim a, mattis quis, suscipit id, libero. Duis vitae justo ut elit ullamcorper vulputate. Morbi euismod magna ac lorem rutrum elementum. Mauris vehicula metus sed diam pulvinar, eu interdum urna iaculis. Nam ut sapien nec sapien fringilla efficitur. Integer ut risus vestibulum, fringilla metus sit amet, facilisis lorem. Nullam condimentum ultricies metus, ac pretium velit ultricies sit amet. Curabitur nec magna eget urna aliquet vestibulum. Maecenas auctor libero sit amet metus vestibulum, ac aliquet tortor cursus. Duis aliquam varius nunc, quis fringilla nisi tincidunt non. Sed scelerisque urna at felis fermentum, a vulputate turpis tempor. Cras volutpat, lectus ac convallis ultrices, mauris erat ultricies dolor, sed euismod lacus nisi at justo. Aenean mollis lectus velit, nec pellentesque erat volutpat id. Integer in turpis nec justo luctus scelerisque. Sed fermentum velit in justo aliquam, sit amet venenatis dolor egestas. Nulla facilisi. Nullam vel dui nec mauris tristique vestibulum. Suspendisse potenti. Nullam blandit magna id malesuada lacinia. Nullam eu velit orci. Curabitur pharetra, leo in aliquet tristique, felis nisi egestas ligula, nec consectetur leo elit vel quam. Donec et mi non arcu tempor dapibus. Phasellus sit amet vehicula libero. Aliquam tincidunt sapien ac elit cursus, non dictum sapien pretium. Etiam sit amet justo vel turpis efficitur tempus. Phasellus sodales turpis a felis consequat, sit amet ullamcorper nisi malesuada. Cras auctor sem a arcu luctus, sit amet fringilla dui placerat. Aliquam sit amet turpis velit. Curabitur eget nisl eu nulla facilisis vestibulum. Fusce interdum, magna at ultricies tincidunt, justo nulla bibendum neque, ut accumsan magna sem vitae sapien. Nam sagittis nunc et magna faucibus, vel tempus purus faucibus. Nullam quis orci in lectus luctus consequat. Integer eget dolor auctor, vehicula metus id, vehicula metus. Pellentesque in metus sit amet purus viverra varius. Nulla facilisi. Sed a ligula sed ligula volutpat scelerisque. In tempor magna et nulla interdum cursus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Proin nec urna eu enim suscipit luctus ac ut ligula. Aliquam erat volutpat. Etiam sed orci bibendum, fringilla velit ut, venenatis magna. Sed vitae suscipit dolor, vitae venenatis ex. Nam sit amet pharetra mi. Curabitur fermentum libero non felis pretium, in faucibus nisi venenatis. Fusce gravida tempor elit. Donec consequat libero at tortor lacinia, at varius mauris vehicula. Curabitur ac velit magna. Nunc nec ipsum dictum, suscipit nunc sed, varius eros. Nullam aliquam eros et leo fermentum dapibus.")))
                  ],
                )
            ),
          ),
          //expandable text widget
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimensions.bottomHeightBar,
        padding: EdgeInsets.only(top:Dimensions.height30,bottom: Dimensions.height30, left: Dimensions.width20, right: Dimensions.width20),
        decoration: BoxDecoration(
          color: AppColors.buttonBackaroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius20*2),
            topRight: Radius.circular(Dimensions.radius20*2),
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(top:Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
              ),
            
            child: Row(
              children: [
                Icon(Icons.remove, color: AppColors.signColor,),
                SizedBox(width: Dimensions.width10/2,),
                BigText(text: "0",),
                SizedBox(width: Dimensions.width10/2,),
                Icon(Icons.add, color: AppColors.signColor,)
              ]
                
            ),
          ),
            Container(
              padding: EdgeInsets.only(top:Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
              child: BigText(text: "\$10 | Add to cart", color: Colors.white,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: AppColors.mainColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

