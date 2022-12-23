import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uygmimarisikisiler_uyg/cubit/kisi_detay_cubit.dart';
import 'package:uygmimarisikisiler_uyg/entity/kisiler.dart';

class KisiDetaySayfa extends StatefulWidget {
  Kisiler kisi;

  KisiDetaySayfa({required this.kisi});

  @override
  State<KisiDetaySayfa> createState() => _KisiDetaySayfaState();
}

class _KisiDetaySayfaState extends State<KisiDetaySayfa> {
  var tfKisiAd = TextEditingController();
  var tfKisiTel = TextEditingController();

  @override
  void initState() {
    super.initState();
    tfKisiAd.text = widget.kisi.kisi_ad;
    tfKisiTel.text = widget.kisi.kisi_tel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kişi Detay"),
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
                    context.read<KisiDetayCubit>().guncelle(
                        widget.kisi.kisi_id, tfKisiAd.text, tfKisiTel.text);
                    Navigator.pop(context);
                  },
                  child: const Text("GÜNCELLE"))
            ],
          ),
        ),
      ),
    );
  }
}
