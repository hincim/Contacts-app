import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uygmimarisikisiler_uyg/cubit/kisi_kayit_cubit.dart';

class KisiKayitSayfa extends StatefulWidget {
  const KisiKayitSayfa({Key? key}) : super(key: key);

  @override
  State<KisiKayitSayfa> createState() => _KisiKayitSayfaState();
}

class _KisiKayitSayfaState extends State<KisiKayitSayfa> {
  var tfKisiAd = TextEditingController();
  var tfKisiTel = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kişi Kayıt"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 50, left: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                  controller: tfKisiAd,
                  decoration: const InputDecoration(hintText: "Kişi ad")),
              TextField(
                  controller: tfKisiTel,
                  decoration: const InputDecoration(hintText: "Kişi tel")),
              ElevatedButton(
                  onPressed: () {
                    if (tfKisiAd.text.isNotEmpty && tfKisiTel.text.isNotEmpty) {
                      context
                          .read<KisiKayitCubit>()
                          .kayit(tfKisiAd.text, tfKisiTel.text);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("KAYDET"))
            ],
          ),
        ),
      ),
    );
  }
}
