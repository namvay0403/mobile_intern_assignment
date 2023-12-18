import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_intern_assignment/cubit/add_cart/add_cart_cubit.dart';
import 'package:mobile_intern_assignment/cubit/get_data/get_data_cubit.dart';
import 'package:mobile_intern_assignment/utilities/constant.dart';
import 'package:string_to_color/string_to_color.dart';

import '../models/cart_model.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<GetDataCubit>().getData();
  }

  @override
  Widget build(BuildContext context) {
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
            title: Text(
              'Our Products',
              style: TextStyle(fontFamily: fontBoldApp, fontSize: 20),
            ),
          ),
          body: BlocBuilder<GetDataCubit, GetDataState>(
            builder: (context, state) {
              if (state is GetDataLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetDataLoaded) {
                return ListView.builder(
                  itemCount: state.shoes.length,
                  itemBuilder: (context, index) {
                    var shoe = state.shoes[index];
                    return item(
                        id: shoe.id,
                        imageUrl: shoe.image,
                        name: shoe.name,
                        description: shoe.description,
                        price: shoe.price,
                        color: shoe.color);
                  },
                );
              } else if (state is GetDataFailed) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return const Center(
                  child: Text('No data'),
                );
              }
            },
          )),
    );
  }

  Widget item(
      {required int id,
      required String imageUrl,
      required String name,
      required String description,
      required double price,
      required String color}) {
    Color color_convert = ColorUtils.stringToColor(color);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            height: 380,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: color_convert,
              image: DecorationImage(
                  image: NetworkImage(imageUrl), fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(name, style: TextStyle(fontSize: 18, fontFamily: fontBoldApp)),
          SizedBox(
            height: 15,
          ),
          Text(description,
              style: TextStyle(
                  fontSize: 15, fontFamily: fontApp, color: Colors.grey)),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('USD $price',
                  style: TextStyle(fontSize: 18, fontFamily: fontBoldApp)),
              InkWell(
                onTap: () {
                  CartModel cartModel = CartModel(id, 1, price, name, imageUrl);
                  context.read<AddCartCubit>().addCart(cartModel);
                },
                child: Container(
                  height: 40,
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.yellow,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        'ADD TO CART',
                        style: TextStyle(fontFamily: fontBoldApp, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
