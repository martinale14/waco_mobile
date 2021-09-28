import 'package:flutter/material.dart';
import 'package:waco_mobile/components/drawer.dart';
import 'package:waco_mobile/components/menu_btn.dart';
import 'package:waco_mobile/components/publication_card.dart';
import 'package:waco_mobile/models/publication.dart';
import 'package:waco_mobile/providers/publication_provider.dart';
import 'package:waco_mobile/providers/user_provider.dart';
import 'package:waco_mobile/utils/dimens.dart';
import 'package:provider/provider.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  int page = 1;
  late ScrollController _controller;
  List<Publication> pubs = [];
  bool _isLoading = false;
  late UserProvider user;
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        addData();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void addData({bool load = true}) async {
    if (load) {
      _isLoading = true;
      setState(() {});
    }

    pubs = [
      ...pubs,
      ...await PublicationProvider.getPublicaciones(page.toString(), user.uid)
    ];
    if (page != 1) {
      _controller.animateTo(
        _controller.position.pixels + 100,
        duration: const Duration(milliseconds: 250),
        curve: Curves.fastOutSlowIn,
      );
    }
    _isLoading = false;
    page++;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!initialized) {
      user = Provider.of(context);
      addData(load: false);
      setState(() {
        initialized = true;
      });
    }
    ColorScheme palette = Theme.of(context).colorScheme;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: const Icon(
            Icons.home,
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
          title: const Text('Inicio',
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
            pubs.isNotEmpty
                ? ListView.builder(
                    controller: _controller,
                    padding: dimens.symmetric(context, 0.05, 0.05),
                    itemCount: pubs.length,
                    itemBuilder: (context, i) {
                      return PublicationCard(
                        id: pubs[i].id,
                        title: pubs[i].title,
                        body: pubs[i].body,
                        favourite: pubs[i].favorite,
                      );
                    },
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            _isLoading
                ? const _Loading()
                : const SizedBox(
                    width: 0,
                    height: 0,
                  ),
          ],
        ),
        backgroundColor: palette.background,
        endDrawer: const FeedDrawer());
  }
}

class _Loading extends StatelessWidget {
  const _Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
        child: Center(
            child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [CircularProgressIndicator()],
    )));
  }
}
