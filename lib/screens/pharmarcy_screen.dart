import 'package:dro/bloc/cart/cart_action.dart';
import 'package:dro/bloc/cart/cart_bloc.dart';
import 'package:dro/bloc/cart/cart_event.dart';
import 'package:dro/bloc/cart_bloc_provider.dart';
import 'package:dro/model/cart.dart';
import 'package:dro/model/category.dart';
import 'package:dro/model/product.dart';
import 'package:dro/screens/categories_screen.dart';
import 'package:dro/screens/product_detail_screen.dart';
import 'package:dro/utility/data/category_list.dart';
import 'package:dro/utility/data/prouct_list.dart';
import 'package:dro/utility/utils/animation.dart';
import 'package:dro/utility/utils/colors.dart';
import 'package:dro/utility/utils/space.dart';
import 'package:dro/utility/utils/styles.dart';
import 'package:dro/utility/utils/utils.dart';
import 'package:dro/widgets/app_bar.dart/searchable_appbar.dart';
import 'package:dro/widgets/category_item.dart';
import 'package:dro/widgets/delivery_in_lagos.dart';
import 'package:dro/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'cart_screen.dart';
import 'search_screen.dart';

class PharmacyScreen extends StatefulWidget {
  const PharmacyScreen({Key? key}) : super(key: key);

  @override
  _PharmacyScreenState createState() => _PharmacyScreenState();
}

class _PharmacyScreenState extends State<PharmacyScreen> {
  late final CartBloc _cartBloc;

  @override
  void initState() {
    super.initState();
  }

  void navigateToSearchScreen() {
    Navigator.push(context, SlideRightRoute(page: const SearchScreen()));
  }

  @override
  Widget build(BuildContext context) {
    _cartBloc = CartBlocProvider.of(context)!.cartBloc;
    _cartBloc.cartEventSink.add(CartAction(event: CartEvent.getCartList));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(171.h),
        child: SearchableAppBar(
          navigateToSearchScreen: navigateToSearchScreen,
        ),
      ),
      body: SizedBox(
        width: deviceWidth(context),
        height: deviceHeight(context), //const Color(0xffF2F2F2),
        child: Column(
          children: [
            Expanded(
                child: ListView(
              children: [
                const DeliveryInLagos(),
                VSpace(16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Styles.regular("CATEGORIES",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: lightGrey),
                      InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CategoriesScreen())),
                        child: Styles.regular("VIEW ALL",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: txtPurple),
                      ),
                    ],
                  ),
                ),
                VSpace(16.h),
                SizedBox(
                    height: 120.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: categories.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return HSpace(12.w);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        Category category = categories[index];
                        return SizedBox(
                            width: 135.h,
                            height: 98.w,
                            child: CategoryItem(category: category));
                      },
                    )),
                VSpace(30.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Styles.regular("SUGGESTIONS",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: lightGrey),
                ),
                VSpace(21.h),
                GridView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 30,
                        crossAxisSpacing: 20,
                        childAspectRatio: aspectRatio(context) * 0.66),
                    itemBuilder: (BuildContext context, int index) {
                      Product product = products[index];
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              // MaterialPageRoute(builder: (context) => CreateAccount()),
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailScreen(product: product)),
                            );
                          },
                          child: ProductItem(product: product));
                    })
              ],
            ))
          ],
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
            context,
            // MaterialPageRoute(builder: (context) => CreateAccount()),
            MaterialPageRoute(builder: (context) => const CartScreen()),
          );
        },
        child: Container(
          width: 135.w,
          height: 43.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.sp),
              boxShadow: const [
                BoxShadow(
                    color: shadowYellow,
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(2, 4))
              ],
              gradient: const LinearGradient(
                  colors: [Color(0xffFE806F), Color(0xffE5366A)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight),
              border: Border.all(color: white, width: 3)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Styles.bold("checkout", fontSize: 14.sp, color: white),
              const Icon(
                Icons.shopping_cart_outlined,
                size: 16,
                color: Colors.white,
              ),
              Container(
                width: 18.w,
                height: 18.h,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.yellow,
                ),
                child: StreamBuilder<List<Cart>>(
                    stream: _cartBloc.cartListStream,
                    initialData: const [],
                    builder: (context, snapshot) {
                      return Styles.extraBold("${snapshot.data!.length}",
                          fontSize: 12.sp);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
