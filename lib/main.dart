import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uygmimarisikisiler_uyg/cubit/anasayfa_cubit.dart';
import 'package:uygmimarisikisiler_uyg/cubit/kisi_detay_cubit.dart';
import 'package:uygmimarisikisiler_uyg/cubit/kisi_kayit_cubit.dart';
import 'package:uygmimarisikisiler_uyg/views/anasayfa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => KisiKayitCubit(),
        ),
        BlocProvider(
          create: (context) => KisiDetayCubit(),
        ),
        BlocProvider(
          create: (context) => AnasayfaCubit(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: const Anasayfa(),
      ),
    );
  }
}
