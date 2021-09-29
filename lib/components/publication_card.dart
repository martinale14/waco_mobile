import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:waco_mobile/models/user_likes.dart';
import 'package:waco_mobile/providers/user_likes_provider.dart';
import 'package:waco_mobile/providers/user_provider.dart';
import 'package:waco_mobile/utils/dimens.dart';
import 'package:waco_mobile/components/radiant_gradient_mask.dart';
import 'package:provider/provider.dart';

class PublicationCard extends StatefulWidget {
  const PublicationCard({
    Key? key,
    required this.id,
    required this.title,
    required this.body,
    required this.favourite,
    this.onFavorite,
  }) : super(key: key);

  final String title;
  final String body;
  final int id;
  final bool favourite;
  final Function? onFavorite;

  @override
  State<PublicationCard> createState() => _PublicationCardState();
}

class _PublicationCardState extends State<PublicationCard> {
  late bool favorite;

  @override
  void initState() {
    super.initState();
    favorite = widget.favourite;
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider user = Provider.of(context);
    ColorScheme palette = Theme.of(context).colorScheme;
    Shader linearGradient =
        LinearGradient(colors: [palette.primary, palette.secondary])
            .createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    return Container(
      padding: dimens.fromLTRB(context, 0, 0, 0, 0.05),
      child: Container(
        padding: dimens.symmetric(context, 0.1, 0.08),
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style:
                      TextStyle(foreground: Paint()..shader = linearGradient),
                ),
                InkWell(
                    onTap: () async {
                      favorite = !favorite;

                      if (favorite) {
                        try {
                          UserLikes userLikes =
                              await UserLikesProvider.getLikes(user.uid);
                          CollectionReference usersLikes = FirebaseFirestore
                              .instance
                              .collection('usersLikes');
                          usersLikes.doc(user.uid).set(
                            {
                              "likes": [widget.id, ...userLikes.likes]
                            },
                          );
                        } catch (e) {
                          CollectionReference usersLikes = FirebaseFirestore
                              .instance
                              .collection('usersLikes');
                          usersLikes.doc(user.uid).set(
                            {
                              "likes": [widget.id]
                            },
                          );
                        }
                      } else {
                        try {
                          UserLikes userLikes =
                              await UserLikesProvider.getLikes(user.uid);
                          List<int> newLikes = userLikes.likes
                              .where((like) => like != widget.id)
                              .toList();
                          CollectionReference usersLikes = FirebaseFirestore
                              .instance
                              .collection('usersLikes');
                          usersLikes.doc(user.uid).set({"likes": newLikes});
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      }
                      setState(() {});
                      if (widget.onFavorite != null) {
                        widget.onFavorite!();
                      }
                    },
                    child: SizedBox(
                      width: 32,
                      height: 32,
                      child: favorite
                          ? const LinearGradientMask(
                              child: Icon(
                                Icons.favorite,
                                size: 32,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(
                              Icons.favorite,
                              size: 32,
                              color: Colors.white60,
                            ),
                    )),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              widget.body,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
