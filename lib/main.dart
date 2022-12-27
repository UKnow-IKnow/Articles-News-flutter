import 'package:articles_news/controller/home_cubit.dart';
import 'package:articles_news/utils/common_function.dart';
import 'package:articles_news/utils/coustom_routes.dart';
import 'package:articles_news/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await mainInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (BuildContext context) => HomeCubit(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Home.routeName,
        onGenerateRoute: CustomRoutes.generateRoute,
      ),
    );
  }
}
