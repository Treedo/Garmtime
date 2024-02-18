import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  Future<void> urlIT() async {
    final Uri url = Uri.parse('https://t.me/InspirationTechnologyBot');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch url');
    }
  }

  Future<void> urlGit() async {
    final Uri url = Uri.parse('https://github.com/Treedo/Garm-Time');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch url');
    }
  }

  Future<void> urlDonate() async {
    final Uri url = Uri.parse('https://donate.hutico.org/garm_time');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        child: Column(
          children: [
            const Center(
                child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                  '''Нумерологія - це вчення, яке досліджує символічне значення чисел і їх вплив на життя людини. 
      
        "Особисті роки" вказують на конкретні етапи в житті людини та надають певні поради та напрямки для дій у кожен із цих періодів. Основні ідеї:
      
          1.  Самопізнання: Нумерологія може сприяти самопізнанню, допомагаючи кожному із нас розуміти, які аспекти життя для нас важливі, і як використовувати свої сильні сторони для досягнення успіху.
          2.  Гармонія: Враховуючи рекомендації на кожен особистий рік, можна працювати над гармонією в різних аспектах життя, таких як кар'єра, відносини, освіта та духовний розвиток.
          3.  Планування: Це може допомогти створити певний план дій на кожен рік, спираючись на власні потреби і можливості.
          4.  Духовний розвиток: Враховуючи духовні аспекти в житті, нумерологія може вдошкулювати інтерес до самопізнання та духовної практики.'''),
            )),
            const Padding(padding: EdgeInsets.all(16.0)),
            Center(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.92,
                  child: ElevatedButton(
                    onPressed: urlIT,
                    child: const Text('Спробуй в Telegram Технологію Натхнення'),
                  )),
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            Center(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.92,
                  child: ElevatedButton(
                    onPressed: urlGit,
                    child: const Text('Сторінка відкритого проекту в GIT'),
                  )),
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.92,
                child: ElevatedButton(
                  onPressed: urlDonate,
                  child: const Text('Допомогти в розвитку проекту'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
