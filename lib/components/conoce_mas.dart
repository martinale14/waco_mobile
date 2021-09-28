import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waco_mobile/components/gradient_button.dart';
import 'package:waco_mobile/utils/dimens.dart';

class ConoceMas extends StatelessWidget {
  const ConoceMas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme palette = Theme.of(context).colorScheme;
    Shader linearGradient =
        LinearGradient(colors: [palette.primary, palette.secondary])
            .createShader(const Rect.fromLTWH(0.0, 0.0, 400.0, 70.0));
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            const Image(
              image: AssetImage('assets/images/conoceMasBg.png'),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Gracias por',
                  style: textTheme.bodyText1,
                ),
                Text(
                  'Completar el ejercicio',
                  style:
                      TextStyle(foreground: Paint()..shader = linearGradient),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Te invitamos a ver más información',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: dimens.fromLTRB(context, 0.17, 0.1, 0.17, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        onTap: () async {
                          const String url =
                              'https://www.instagram.com/waconomads/';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor:
                                    Theme.of(context).colorScheme.surface,
                                content: const Text(
                                    'La página web no puede ser lanzada'),
                                action: SnackBarAction(
                                  textColor: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  label: 'vale',
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                  },
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          padding: dimens.all(context, .02),
                          child: SvgPicture.asset('assets/svg/instagram.svg'),
                        ),
                      ),
                      Button(
                          label: 'Conocer más',
                          buttonTap: () async {
                            const String url = 'https://wacoservices.com/';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.surface,
                                  content: const Text(
                                      'La página web no puede ser lanzada'),
                                  action: SnackBarAction(
                                    textColor: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                    label: 'vale',
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                    },
                                  ),
                                ),
                              );
                            }
                          }),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
