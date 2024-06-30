import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_app/app_router.dart';

void main() {
  runApp( TVApp(appRouter: AppRouter(),));
}

class TVApp extends StatelessWidget {

  final AppRouter appRouter;

  const TVApp ({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}