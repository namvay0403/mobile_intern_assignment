import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_intern_assignment/cubit/add_cart/add_cart_cubit.dart';
import 'package:mobile_intern_assignment/cubit/get_data/get_data_cubit.dart';
import 'package:mobile_intern_assignment/pages/screen1.dart';
import 'package:mobile_intern_assignment/pages/screen2.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetDataCubit(),
      child: BlocProvider(
        create: (context) => AddCartCubit(),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Screen1(),
              SizedBox(width: 100),
              Screen2(),
            ],
          ),
        ),
      ),
    );
  }
}
