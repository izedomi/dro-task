import 'package:dro/bloc/cart/cart_action.dart';
import 'package:dro/bloc/cart/cart_bloc.dart';
import 'package:dro/bloc/cart/cart_event.dart';
import 'package:dro/bloc/cart_bloc_provider.dart';
import 'package:dro/bloc/product/product_action.dart';
import 'package:dro/bloc/product/product_bloc.dart';
import 'package:dro/bloc/product/product_event.dart';
import 'package:dro/model/product.dart';
import 'package:dro/utility/data/prouct_list.dart';
import 'package:dro/utility/routes/route_paths.dart';
import 'package:dro/utility/utils/colors.dart';
import 'package:dro/utility/utils/snackbar.dart';
import 'package:dro/utility/utils/space.dart';
import 'package:dro/utility/utils/styles.dart';
import 'package:dro/utility/utils/utils.dart';
import 'package:dro/widgets/add_to_wishlist.dart';
import 'package:dro/widgets/app_bar.dart/shared_appbar.dart';
import 'package:dro/widgets/buttons/custom_outline_button.dart';
import 'package:dro/widgets/buttons/custom_solid_button.dart';
import 'package:dro/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({required this.product, Key? key})
      : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int qty = 1;
  final numberFormat = NumberFormat("#,##0", "en_US");
  late ProductBloc _productBloc;
  late final CartBloc _cartBloc;

  @override
  void initState() {
    super.initState();
    _productBloc = ProductBloc();
  }

  @override
  Widget build(BuildContext context) {
    _cartBloc = CartBlocProvider.of(context)!.cartBloc;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(120.h),
            child: const SharedAppBar(
              title: "Pharmacy",
            )),
        body: SizedBox(
          height: deviceHeight(context),
          width: deviceWidth(context),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    VSpace(24.h),
                    SizedBox(
                        height: 170.h,
                        width: 170.w,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.asset(widget.product.image,
                                fit: BoxFit.cover))),
                    VSpace(16.h),
                    Align(
                        alignment: Alignment.center,
                        child:
                            Styles.bold(widget.product.name, fontSize: 20.sp)),
                    Align(
                        alignment: Alignment.center,
                        child: Styles.regular(
                            widget.product.type +
                                " - " +
                                widget.product.packSize,
                            fontSize: 18.sp,
                            color: lightGrey)),
                    VSpace(16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                                height: 50,
                                width: 50,
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child:
                                    Image.asset("assets/images/sold_by.png")),
                            HSpace(10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Styles.bold("SOLD BY",
                                    color: katiGrey, fontSize: 10.sp),
                                Styles.bold("Emzor Pharmaceuticals",
                                    color: shadowBlue, fontSize: 14.sp),
                              ],
                            ),
                          ],
                        ),
                        const AddTOWishList()
                      ],
                    ),
                    VSpace(18.h),
                    StreamBuilder<int>(
                        stream: _productBloc.counterStream,
                        initialData: 1,
                        builder: (context, snapshot) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                Container(
                                    height: 40.h,
                                    width: 96.w,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 6.h),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            width: 1, color: Colors.grey)),
                                    child: StreamBuilder<int>(
                                        stream: _productBloc.counterStream,
                                        initialData: 1,
                                        builder: (context, snapshot) {
                                          return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      // decreaseQty();
                                                      _productBloc
                                                          .productEventSink
                                                          .add(ProductAction(
                                                              event: ProductEvent
                                                                  .decrease));
                                                    },
                                                    child: Icon(
                                                      Icons.remove,
                                                      size: 20.sp,
                                                    )),
                                                HSpace(8.w),
                                                Styles.bold(
                                                    snapshot.data!.toString(),
                                                    fontSize: 20.sp),
                                                HSpace(8.w),
                                                GestureDetector(
                                                    onTap: () {
                                                      // increaseQty();
                                                      _productBloc
                                                          .productEventSink
                                                          .add(ProductAction(
                                                              event: ProductEvent
                                                                  .increase));
                                                    },
                                                    child: Icon(
                                                      Icons.add,
                                                      size: 20.sp,
                                                    ))
                                              ]);
                                        })),
                                HSpace(8.w),
                                Text(snapshot.data == 1 ? "Pack" : "Packs",
                                    style: TextStyle(
                                        color: Colors.grey[500], fontSize: 12))
                              ]),
                              Row(
                                children: [
                                  RichText(
                                    text: WidgetSpan(
                                      child: Transform.translate(
                                        offset: const Offset(2, -4),
                                        child: const Text(
                                          '₦',
                                          //superscript is usually smaller in size
                                          textScaleFactor: 0.6,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  HSpace(2.w),
                                  Styles.bold(
                                      numberFormat.format(double.parse(
                                          (snapshot.data! *
                                                  widget.product.price)
                                              .toString())),
                                      fontSize: 20.sp,
                                      color: black),
                                ],
                              ),
                            ],
                          );
                        }),
                    VSpace(30.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Styles.bold("PRODUCT DETAILS",
                          align: TextAlign.left,
                          fontSize: 14.sp,
                          color: katiGrey),
                    ),
                    VSpace(18.h),
                    Row(
                      children: [
                        Expanded(
                            flex: 5,
                            child: buildX(Icons.fullscreen_outlined,
                                "PACK SIZE", "8 x 12 tablets (96)")),
                        Expanded(
                          flex: 5,
                          child: buildX(Icons.center_focus_weak, "PRODUCT ID",
                              "PRO23648856"),
                        ),
                      ],
                    ),
                    VSpace(14.h),
                    Row(
                      children: [
                        Expanded(
                            flex: 5,
                            child: buildX(Icons.nfc_outlined, "CONSTITUENTS",
                                widget.product.name)),
                        Expanded(
                          flex: 5,
                          child:
                              buildX(Icons.inventory, "DISPENSED IN", "Packs"),
                        ),
                      ],
                    ),
                    VSpace(36.h),
                    Styles.regular(
                        "1 pack of Emzor Paracetamol (500mg) contains 8 units of 12 tablets.",
                        fontSize: 14.sp,
                        color: lightGrey),
                    VSpace(16.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Styles.bold("Similar Products",
                          fontSize: 18.sp, color: altoGrey),
                    ),
                  ],
                ),
              ),
              VSpace(8.h),
              SizedBox(
                  height: 250.h,
                  width: deviceWidth(context),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: products.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return HSpace(12.w);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      Product product = products[index];
                      return SizedBox(
                          width: 155.w,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => CreateAccount()),
                                MaterialPageRoute(
                                    builder: (context) => ProductDetailScreen(
                                          product: product,
                                        )),
                              );
                            },
                            child: ProductItem(
                              product: product,
                              showPrescriptionOverlay: false,
                            ),
                          ));
                    },
                  )),
              VSpace(30.h),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: CustomSolidButton("Add to cart", onTap: () {
                    if (_cartBloc.alreadyInCart(widget.product)) {
                      showSnackBar(context, msg: "Item already added to cart");
                      return;
                    }
                    _cartBloc.cartEventSink.add(CartAction(
                        event: CartEvent.addToCart,
                        data: {
                          "product": widget.product,
                          "quantity": _productBloc.getCounter()
                        }));

                    addToCartBottomSheet();
                  })),
              VSpace(30.h)
            ],
          ),
        ));
  }

  void increaseQty() {
    setState(() => qty = qty + 1);
  }

  void decreaseQty() {
    if (qty == 1) return;
    setState(() => qty = qty - 1);
  }

  Widget buildX(IconData icon, String title, String subTitle) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor),
        HSpace(6.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Styles.regular(title, color: katiGrey, fontSize: 10.sp),
            Styles.bold(subTitle, color: shadowBlue, fontSize: 14.sp)
          ],
        )
      ],
    );
  }

  void addToCartBottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.sp),
              topRight: Radius.circular(24.sp)),
        ),
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              VSpace(64.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Styles.regular(
                    "Emzor paracetamol has been successfully added to cart!",
                    color: lightGrey,
                    align: TextAlign.center,
                    fontSize: 20.sp),
              ),
              VSpace(68.h),
              CustomSolidButton("VIEW CART", hasIcon: false, onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, RoutePaths.cart);
              }),
              VSpace(16.h),
              CustomOutlineButton("CONTINUE SHOPPING",
                  fontSize: 15.sp, width: 364.w, height: 50.h, onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, RoutePaths.pharmacy);
              }),
              VSpace(24.h),
            ],
          );
        });
  }
}
