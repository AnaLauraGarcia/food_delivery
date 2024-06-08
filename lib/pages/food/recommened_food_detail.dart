import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';


class RecommendedFoodDetail extends StatelessWidget {
  const RecommendedFoodDetail ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(icon: Icons.clear),
                ),
                AppIcon(icon: Icons.shopping_cart_outlined),
            ],),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                
               
                child: Center(child: BigText(size:Dimensions.font26, text: "Chinese Side")),
                width: double.maxFinite,
                padding: EdgeInsets.only(top:5, bottom: 10),
                decoration: BoxDecoration(
                  color:Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20),
                    ),
                      
                      
                      ),
                    ),
              ),
            
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/image/food1.png",
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: ExpandableTextWidget(text:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Curabitur pretium tincidunt lacus. Nulla gravida orci a odio. Nullam varius, turpis et commodo pharetra, est eros bibendum elit. Suspendisse nec magna sit amet risus vehicula tincidunt. Proin justo purus, dignissim a, mattis quis, suscipit id, libero. Duis vitae justo ut elit ullamcorper vulputate. Morbi euismod magna ac lorem rutrum elementum. Mauris vehicula metus sed diam pulvinar, eu interdum urna iaculis. Nam ut sapien nec sapien fringilla efficitur. Integer ut risus vestibulum, fringilla metus sit amet, facilisis lorem. Nullam condimentum ultricies metus, ac pretium velit ultricies sit amet. Curabitur nec magna eget urna aliquet vestibulum. Maecenas auctor libero sit amet metus vestibulum, ac aliquet tortor cursus. Duis aliquam varius nunc, quis fringilla nisi tincidunt non. Sed scelerisque urna at felis fermentum, a vulputate turpis tempor. Cras volutpat, lectus ac convallis ultrices, mauris erat ultricies dolor, sed euismod lacus nisi at justo. Aenean mollis lectus velit, nec pellentesque erat volutpat id. Integer in turpis nec justo luctus scelerisque. Sed fermentum velit in justo aliquam, sit amet venenatis dolor egestas. Nulla facilisi. Nullam vel dui nec mauris tristique vestibulum. Suspendisse potenti. Nullam blandit magna id malesuada lacinia. Nullam eu velit orci. Curabitur pharetra, leo in aliquet tristique, felis nisi egestas ligula, nec consectetur leo elit vel quam. Donec et mi non arcu tempor dapibus. Phasellus sit amet vehicula libero. Aliquam tincidunt sapien ac elit cursus, non dictum sapien pretium. Etiam sit amet justo vel turpis efficitur tempus. Phasellus sodales turpis a felis consequat, sit amet ullamcorper nisi malesuada. Cras auctor sem a arcu luctus, sit amet fringilla dui placerat. Aliquam sit amet turpis velit. Curabitur eget nisl eu nulla facilisis vestibulum. Fusce interdum, magna at ultricies tincidunt, justo nulla bibendum neque, ut accumsan magna sem vitae sapien. Nam sagittis nunc et magna faucibus, vel tempus purus faucibus. Nullam quis orci in lectus luctus consequat. Integer eget dolor auctor, vehicula metus id, vehicula metus. Pellentesque in metus sit amet purus viverra varius. Nulla facilisi. Sed a ligula sed ligula volutpat scelerisque. In tempor magna et nulla interdum cursus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Proin nec urna eu enim suscipit luctus ac ut ligula. Aliquam erat volutpat. Etiam sed orci bibendum, fringilla velit ut, venenatis magna. Sed vitae suscipit dolor, vitae venenatis ex. Nam sit amet pharetra mi. Curabitur fermentum libero non felis pretium, in faucibus nisi venenatis. Fusce gravida tempor elit. Donec consequat libero at tortor lacinia, at varius mauris vehicula. Curabitur ac velit magna. Nunc nec ipsum dictum, suscipit nunc sed, varius eros. Nullam aliquam eros et leo fermentum dapibus.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Curabitur pretium tincidunt lacus. Nulla gravida orci a odio. Nullam varius, turpis et commodo pharetra, est eros bibendum elit. Suspendisse nec magna sit amet risus vehicula tincidunt. Proin justo purus, dignissim a, mattis quis, suscipit id, libero. Duis vitae justo ut elit ullamcorper vulputate. Morbi euismod magna ac lorem rutrum elementum. Mauris vehicula metus sed diam pulvinar, eu interdum urna iaculis. Nam ut sapien nec sapien fringilla efficitur. Integer ut risus vestibulum, fringilla metus sit amet, facilisis lorem. Nullam condimentum ultricies metus, ac pretium velit ultricies sit amet. Curabitur nec magna eget urna aliquet vestibulum. Maecenas auctor libero sit amet metus vestibulum, ac aliquet tortor cursus. Duis aliquam varius nunc, quis fringilla nisi tincidunt non. Sed scelerisque urna at felis fermentum, a vulputate turpis tempor. Cras volutpat, lectus ac convallis ultrices, mauris erat ultricies dolor, sed euismod lacus nisi at justo. Aenean mollis lectus velit, nec pellentesque erat volutpat id. Integer in turpis nec justo luctus scelerisque. Sed fermentum velit in justo aliquam, sit amet venenatis dolor egestas. Nulla facilisi. Nullam vel dui nec mauris tristique vestibulum. Suspendisse potenti. Nullam blandit magna id malesuada lacinia. Nullam eu velit orci. Curabitur pharetra, leo in aliquet tristique, felis nisi egestas ligula, nec consectetur leo elit vel quam. Donec et mi non arcu tempor dapibus. Phasellus sit amet vehicula libero. Aliquam tincidunt sapien ac elit cursus, non dictum sapien pretium. Etiam sit amet justo vel turpis efficitur tempus. Phasellus sodales turpis a felis consequat, sit amet ullamcorper nisi malesuada. Cras auctor sem a arcu luctus, sit amet fringilla dui placerat. Aliquam sit amet turpis velit. Curabitur eget nisl eu nulla facilisis vestibulum. Fusce interdum, magna at ultricies tincidunt, justo nulla bibendum neque, ut accumsan magna sem vitae sapien. Nam sagittis nunc et magna faucibus, vel tempus purus faucibus. Nullam quis orci in lectus luctus consequat. Integer eget dolor auctor, vehicula metus id, vehicula metus. Pellentesque in metus sit amet purus viverra varius. Nulla facilisi. Sed a ligula sed ligula volutpat scelerisque. In tempor magna et nulla interdum cursus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Proin nec urna eu enim suscipit luctus ac ut ligula. Aliquam erat volutpat. Etiam sed orci bibendum, fringilla velit ut, venenatis magna. Sed vitae suscipit dolor, vitae venenatis ex. Nam sit amet pharetra mi. Curabitur fermentum libero non felis pretium, in faucibus nisi venenatis. Fusce gravida tempor elit. Donec consequat libero at tortor lacinia, at varius mauris vehicula. Curabitur ac velit magna. Nunc nec ipsum dictum, suscipit nunc sed, varius eros. Nullam aliquam eros et leo fermentum dapibus."),
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20) ,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: Dimensions.width20*2.5,
              right: Dimensions.width20*2.5,
              top: Dimensions.height10,
              bottom: Dimensions.height10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  iconColor: Colors.white, 
                  iconSize: Dimensions.iconSize24,
                  backgroundColor: AppColors.mainColor, 
                  icon: Icons.remove),
                BigText(text: "\$12.88 "+"X "+" 0 ",color: AppColors.mainBlackColor, size: Dimensions.font26),
                AppIcon(
                  iconColor: Colors.white, 
                  iconSize: Dimensions.iconSize24,
                  backgroundColor: AppColors.mainColor, 
                  icon: Icons.add),
              ],
            ),
          ),
          Container(
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
                
                child: Icon(
                  Icons.favorite,
                  color: AppColors.mainColor
                )
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
        ],      
      ),
    );
  }
}

//4:48