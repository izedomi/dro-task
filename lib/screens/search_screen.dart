import 'package:dro/bloc/cart/cart_action.dart';
import 'package:dro/bloc/cart/cart_event.dart';
import 'package:dro/bloc/cart_bloc_provider.dart';
import 'package:dro/bloc/product/product_action.dart';
import 'package:dro/bloc/product/product_bloc.dart';
import 'package:dro/bloc/product/product_event.dart';
import 'package:dro/model/cart.dart';
import 'package:dro/model/product.dart';
import 'package:dro/screens/product_detail_screen.dart';
import 'package:dro/utility/data/prouct_list.dart';
import 'package:dro/utility/utils/colors.dart';
import 'package:dro/utility/utils/snackbar.dart';
import 'package:dro/utility/utils/space.dart';
import 'package:dro/utility/utils/styles.dart';
import 'package:dro/utility/utils/utils.dart';
import 'package:dro/widgets/app_bar.dart/searchable_appbar.dart';
import 'package:dro/widgets/delivery_in_lagos.dart';
import 'package:dro/widgets/empty_state.dart';
import 'package:dro/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:badges/badges.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late ProductBloc _productBloc;
  String queryString = "";

  @override
  void initState() {
    super.initState();
    _productBloc = ProductBloc();
  }

  searchProduct(String q) {
    queryString = q;
    if (queryString.isEmpty) {
      showSnackBar(context, msg: "Please enter a product name");
      return;
    }
    _productBloc.productEventSink.add(ProductAction(
        event: ProductEvent.search, data: {"query": queryString}));
  }

  @override
  Widget build(BuildContext context) {
    final _cartBloc = CartBlocProvider.of(context)!.cartBloc;
    _cartBloc.cartEventSink.add(CartAction(event: CartEvent.getCartList));

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(171.h),
          child: SearchableAppBar(
            canSearch: true,
            searchProduct: searchProduct,
          )),
      body: SizedBox(
          width: deviceWidth(context),
          height: deviceHeight(context), //const Color(0xffF2F2F2),
          child:
              searchContent()), // EmptyState(""No result found for \"Paracetamol\""")
      floatingActionButton: Container(
        width: 43.w,
        height: 43.h,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
                colors: [Color(0xffFE806F), Color(0xffE5366A)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight),
            boxShadow: const [
              BoxShadow(
                  color: shadowYellow,
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset(2, 4))
            ],
            border: Border.all(color: white, width: 3)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Badge(
              badgeColor: Colors.yellow,
              position: BadgePosition.topEnd(top: -14, end: -14),
              badgeContent: StreamBuilder<List<Cart>>(
                  stream: _cartBloc.cartListStream,
                  initialData: const [],
                  builder: (context, snapshot) {
                    return Styles.extraBold("${snapshot.data!.length}",
                        fontSize: 12.sp);
                  }),
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 16,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget searchContent() {
    return StreamBuilder<List<Product>>(
        stream: _productBloc.filteredProductStream,
        initialData: products,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                    child: ListView(
                  children: [
                    const DeliveryInLagos(),
                    VSpace(16.h),
                    GridView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 30,
                            crossAxisSpacing: 20,
                            childAspectRatio: aspectRatio(context) * 0.5),
                        itemBuilder: (BuildContext context, int index) {
                          Product product = snapshot.data![index];
                          return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  // MaterialPageRoute(builder: (context) => CreateAccount()),
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetailScreen(
                                          product: product)),
                                );
                              },
                              child: ProductItem(
                                product: product,
                                showButton: true,
                              ));
                        })
                  ],
                ))
              ],
            );
          } else {
            return EmptyState(label: "No product found for \"$queryString\"");
          }
        });
  }
}
