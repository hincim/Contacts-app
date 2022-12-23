import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uygmimarisikisiler_uyg/cubit/anasayfa_cubit.dart';
import 'package:uygmimarisikisiler_uyg/entity/kisiler.dart';
import 'package:uygmimarisikisiler_uyg/views/kisi_detay_sayfa.dart';
import 'package:uygmimarisikisiler_uyg/views/kisi_kayit_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> with TickerProviderStateMixin {
  bool aramaYapiliyorMu = false;

  late AnimationController animasyonKontrol;

  late Animation<double> translateAnimasyonDegerleri;

  late Animation<double> alphaAnimasyonDegerleri;

  bool kisilerDurum = false;

  @override
  void initState() {
    super.initState();
    animasyonKontrol = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    translateAnimasyonDegerleri = Tween(begin: -800.0, end: 0.0).animate(
        CurvedAnimation(parent: animasyonKontrol, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      });
    alphaAnimasyonDegerleri =
        Tween(begin: 0.0, end: 1.0).animate(animasyonKontrol)
          ..addListener(() {
            setState(() {});
          });
    context.read<AnasayfaCubit>().kisileriYukle();
    animasyonKontrol.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animasyonKontrol.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: aramaYapiliyorMu
            ? TextField(
                decoration: const InputDecoration(hintText: "Birşeyler yazın"),
                onChanged: (aramaSonucu) {
                  context.read<AnasayfaCubit>().ara(aramaSonucu);
                },
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.translate(
                      offset: Offset(translateAnimasyonDegerleri.value, 0.0),
                      child: Text("Kişiler")),
                  SizedBox(
                    width: 5,
                  ),
                  Transform.translate(
                      offset: Offset(0.0, translateAnimasyonDegerleri.value),
                      child: Icon(
                        Icons.person,
                        color: Colors.black45,
                      ))
                ],
              ),
        actions: [
          aramaYapiliyorMu
              ? IconButton(
                  onPressed: () {
                    animasyonKontrol.forward();
                    setState(() {
                      aramaYapiliyorMu = false;
                      context.read<AnasayfaCubit>().kisileriYukle();
                    });
                  },
                  icon: const Icon(Icons.cancel))
              : IconButton(
                  onPressed: () {
                    animasyonKontrol.reverse();
                    setState(() {
                      aramaYapiliyorMu = true;
                    });
                  },
                  icon: const Icon(Icons.search))
        ],
      ),
      body: BlocBuilder<AnasayfaCubit, List<Kisiler>>(
        builder: (context, kisilerListesi) {
          if (kisilerListesi.isNotEmpty) {
            return ListView.builder(
              itemCount: kisilerListesi.length,
              itemBuilder: (context, index) {
                var gelenKisi = kisilerListesi[index];
                return GestureDetector(
                  onTap: () {
                    animasyonKontrol.reverse();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KisiDetaySayfa(kisi: gelenKisi),
                        )).then((value) {
                      print("Anasayfaya dönüldü");
                      animasyonKontrol.forward();
                      context.read<AnasayfaCubit>().kisileriYukle();
                    });
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("${gelenKisi.kisi_ad} - ${gelenKisi.kisi_tel}"),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "${gelenKisi.kisi_ad} silinsin mi?"),
                                        action: SnackBarAction(
                                            label: "Evet",
                                            onPressed: () {
                                              context
                                                  .read<AnasayfaCubit>()
                                                  .sil(gelenKisi.kisi_id);
                                            })));
                              },
                              icon: const Icon(Icons.delete))
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            animasyonKontrol.reverse();
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const KisiKayitSayfa(),
                )).then((value) {
              context.read<AnasayfaCubit>().kisileriYukle();
              animasyonKontrol.forward();
            });
          },
          backgroundColor: Colors.deepOrange,
          child: const Icon(Icons.add, color: Colors.white)),
    );
  }
}
