import 'package:flutter/material.dart';
import 'package:waco_mobile/components/drawer.dart';
import 'package:waco_mobile/components/menu_btn.dart';
import 'package:waco_mobile/components/publication_card.dart';
import 'package:waco_mobile/models/publication.dart';
import 'package:waco_mobile/providers/publication_provider.dart';
import 'package:waco_mobile/providers/user_provider.dart';
import 'package:waco_mobile/utils/dimens.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<Publication> pubs = [];
  late UserProvider user;
  bool initialized = false;

  void addData({bool load = true}) async {
    pubs = [...await PublicationProvider.getLikedPulications(user.uid)];
    setState(() {
      initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!initialized) {
      user = Provider.of(context);
      addData(load: false);
      setState(() {});
    }
    ColorScheme palette = Theme.of(context).colorScheme;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: const Icon(
            Icons.favorite,
            color: Colors.white,
          ),
          actions: [
            Builder(
              builder: (context) => MenuButton(
                buttonOnTap: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ),
          ],
          title: const Text('Favoritos',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          flexibleSpace: Container(
            decoration: const BoxDecoration(),
          ),
        ),
        body: Stack(
          children: [
            initialized
                ? (pubs.isNotEmpty
                    ? ListView.builder(
                        padding: dimens.symmetric(context, 0.05, 0.05),
                        itemCount: pubs.length,
                        itemBuilder: (context, i) {
                          return PublicationCard(
                            key: Key(pubs[i].id.toString()),
                            id: pubs[i].id,
                            title: pubs[i].title,
                            body: pubs[i].body,
                            favourite: pubs[i].favorite,
                            onFavorite: addData,
                          );
                        },
                      )
                    : const Center(
                        child: Text("Aun no hay favoritos"),
                      ))
                : const Center(
                    child: CircularProgressIndicator(),
                  )
          ],
        ),
        backgroundColor: palette.background,
        endDrawer: const FeedDrawer());
  }
}
