import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_intern_assignment/cubit/add_cart/add_cart_cubit.dart';
import 'package:mobile_intern_assignment/cubit/add_cart/add_cart_cubit.dart';
import 'package:mobile_intern_assignment/cubit/cart/cart_bloc.dart';
import 'package:mobile_intern_assignment/utilities/constant.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CartSuccess) {
          return Container(
            height: 500,
            width: 400,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white)),
            child: Scaffold(
              appBar: AppBar(
                leading: Image.asset(AppAssets.nike),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your Cart',
                      style: TextStyle(fontFamily: fontBoldApp, fontSize: 18),
                    ),
                    Text(
                      'USD ${state.totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(fontFamily: fontBoldApp, fontSize: 18),
                    ),
                  ],
                ),
              ),
              body: ListView.builder(
                itemCount: state.cartModels.length,
                itemBuilder: (context, index) {
                  var item = state.cartModels[index];
                  return itemWidget(item.id, item.imageUrl, item.name,
                      item.price, item.count);
                },
              ),
            ),
          );
        } else if (state is CartFailed) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Container(
            height: 500,
            width: 400,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white)),
            child: Scaffold(
                appBar: AppBar(
                  leading: Image.asset(AppAssets.nike),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your Cart',
                        style: TextStyle(fontFamily: fontBoldApp, fontSize: 18),
                      ),
                      Text(
                        'USD 0.00',
                        style: TextStyle(fontFamily: fontBoldApp, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                body: Center(
                  child: Text('Your cart is empty',
                      style: TextStyle(fontFamily: fontBoldApp, fontSize: 18)),
                )),
          );
        }
      },
    );
  }

  Widget itemWidget(
      int id, String imageUrl, String name, double price, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 35),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(imageUrl),
          ),
          SizedBox(width: 18),
          Container(
            height: 118,
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(fontFamily: fontBoldApp, fontSize: 15)),
                Text('USD ${price.toString()}',
                    style: TextStyle(fontFamily: fontBoldApp, fontSize: 15)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.grey,
                          child: IconButton(
                            icon: Image.network(AppAssets.minus),
                            onPressed: () {
                              if (count > 1) {
                                context
                                    .read<CartBloc>()
                                    .add(CartMinusEvent(id));
                              } else {
                                context
                                    .read<CartBloc>()
                                    .add(CartDeleteEvent(id));
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('$count'),
                        SizedBox(width: 10),
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.grey,
                          child: IconButton(
                            icon: Image.network(AppAssets.plus),
                            onPressed: () {
                              context.read<CartBloc>().add(CartPlusEvent(id));
                            },
                          ),
                        )
                      ],
                    ),
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.yellow,
                      child: IconButton(
                        icon: Image.network(AppAssets.trash),
                        onPressed: () {
                          context.read<CartBloc>().add(CartDeleteEvent(id));
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
