import 'package:dro/bloc/cart/cart_action.dart';
import 'package:dro/bloc/cart/cart_bloc.dart';
import 'package:dro/bloc/cart/cart_event.dart';
import 'package:dro/bloc/cart_bloc_provider.dart';
import 'package:dro/model/cart.dart';
import 'package:dro/utility/routes/route_paths.dart';
import 'package:dro/utility/utils/colors.dart';
import 'package:dro/utility/utils/snackbar.dart';
import 'package:dro/utility/utils/space.dart';
import 'package:dro/utility/utils/styles.dart';
import 'package:dro/utility/utils/utils.dart';
import 'package:dro/widgets/app_bar.dart/shared_appbar.dart';
import 'package:dro/widgets/buttons/custom_outline_button.dart';
import 'package:dro/widgets/buttons/custom_solid_button.dart';
import 'package:dro/widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final numberFormat = NumberFormat("#,##0", "en_US");
  List<String> qtyCount = ["1", "2", "3", "4", "5", "6", "7", "8"];
  late CartBloc _cartBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _cartBloc = CartBlocProvider.of(context)!.cartBloc;
    _cartBloc.cartEventSink.add(CartAction(event: CartEvent.getCartList));

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(121.h),
          child: const SharedAppBar(
            title: "Cart",
            hasCartIcon: false,
          )),
      body: SizedBox(
        width: deviceWidth(context),
        height: deviceHeight(context),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Expanded(
                    flex: 9,
                    child: StreamBuilder<List<Cart>>(
                        stream: _cartBloc.cartListStream,
                        initialData: const [],
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.isNotEmpty) {
                              return ListView.separated(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  itemCount: snapshot.data!.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Divider();
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Cart cart = snapshot.data![index];
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              child: Image.asset(
                                                cart.product.image,
                                                height: 80.h,
                                                width: 80.w,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            // Container(
                                            //     width: 80.w, height: 80.h, color: Colors.red),
                                            HSpace(14.w),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Styles.regular(
                                                      cart.product.name,
                                                      fontSize: 16.sp,
                                                      color: bunkerBlack),
                                                  VSpace(4.h),
                                                  Styles.regular(
                                                      "${cart.product.type}-${cart.product.packSize}",
                                                      color: clayBlack),
                                                  VSpace(9.h),
                                                  Styles.regular(
                                                      "₦" +
                                                          numberFormat.format(
                                                              double.parse((cart
                                                                          .quantity *
                                                                      cart.product
                                                                          .price)
                                                                  .toString())) +
                                                          ".00",
                                                      color: clayGrey,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w600)
                                                ]),
                                          ],
                                        ),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: 58.w,
                                                height: 31.h,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xffc4c4c4)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.sp)),
                                                child: DropdownButton<String>(
                                                  elevation: 0,
                                                  // focusColor: lightGrey,
                                                  // dropdownColor: lightGrey,
                                                  underline: const SizedBox(),
                                                  icon: const Icon(
                                                      Icons
                                                          .arrow_drop_down_sharp,
                                                      color: lightGrey),
                                                  value:
                                                      cart.quantity.toString(),
                                                  onChanged:
                                                      (selectedQuantity) {
                                                    if (selectedQuantity !=
                                                        null) {
                                                      _cartBloc.cartEventSink
                                                          .add(CartAction(
                                                              event: CartEvent
                                                                  .updateQuantity,
                                                              data: {
                                                            "newQuantity":
                                                                int.parse(
                                                                    selectedQuantity),
                                                            "cartIndex": index
                                                          }));
                                                    }
                                                  },
                                                  items: qtyCount
                                                      .map((String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                              VSpace(16.h),
                                              InkWell(
                                                onTap: () => _cartBloc
                                                    .cartEventSink
                                                    .add(CartAction(
                                                        event: CartEvent
                                                            .deleteCartItem,
                                                        data: {
                                                      "cartIndex": index
                                                    })),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.delete_outline,
                                                        size: 20,
                                                        color: txtPurple),
                                                    Styles.regular("Remove",
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w200,
                                                        color: txtPurple)
                                                  ],
                                                ),
                                              )
                                            ])
                                      ],
                                    );
                                  });
                            } else {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const EmptyState(
                                      label: "Your cart is empty!"),
                                  VSpace(24.h),
                                  CustomOutlineButton("CONTINUE SHOPPING",
                                      fontSize: 15.sp,
                                      width: 364.w,
                                      height: 50.h,
                                      onTap: () => Navigator.pushNamed(
                                          context, RoutePaths.pharmacy)),
                                ],
                              );
                            }
                          } else {
                            return const EmptyState(
                                label: "Something went worong!");
                          }
                        })),
                Expanded(
                    flex: 1,
                    child: StreamBuilder<double>(
                        stream: _cartBloc.cartTotalStream,
                        initialData: 0,
                        builder: (context, snapshot) {
                          return snapshot.data! > 0
                              ? Row(
                                  children: [
                                    Expanded(
                                        flex: 4,
                                        child: Styles.regular(
                                            "Total: ₦" +
                                                numberFormat.format(
                                                    double.parse(snapshot.data
                                                        .toString())) +
                                                ".00",
                                            color: clayGrey,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600)),
                                    Expanded(
                                        flex: 6,
                                        child: CustomSolidButton("CHECKOUT",
                                            hasIcon: false, onTap: () {
                                          showSnackBar(context,
                                              msg:
                                                  "Checkout Successful. Your order has placed!",
                                              bgColor: Colors.green);
                                          Future.delayed(
                                              const Duration(seconds: 4), () {
                                            _cartBloc.cartEventSink.add(
                                                CartAction(
                                                    event: CartEvent.checkOut));
                                          });
                                        })),
                                  ],
                                )
                              : const SizedBox();
                        }))
              ],
            )),
      ),
    );
  }
}
