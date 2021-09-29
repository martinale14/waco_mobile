import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:waco_mobile/models/publication.dart';
import 'package:waco_mobile/models/user_likes.dart';
import 'package:waco_mobile/providers/user_likes_provider.dart';

class PublicationProvider {
  static Future<List<Publication>> getPublicaciones(
      String page, String uid) async {
    List<Publication> pubs = [];
    try {
      final response =
          await Dio().get('http://waco-api.herokuapp.com/api/posts?page=$page');
      Map<String, dynamic> data = json.decode(response.toString());
      for (var publication in data['data']) {
        pubs.add(Publication(
            id: publication['id'],
            title: publication['title'],
            body: publication['body'],
            userId: publication['user'],
            link: publication['link']));
      }

      try {
        UserLikes userLikes = await UserLikesProvider.getLikes(uid);
        for (Publication pub in pubs) {
          for (int id in userLikes.likes) {
            if (pub.id == id) {
              pub.favorite = true;
            }
          }
        }
      } catch (e) {
        return pubs;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return pubs;
  }

  static Future<List<Publication>> getLikedPulications(String uid) async {
    List<Publication> pubs = [];
    try {
      UserLikes userLikes = await UserLikesProvider.getLikes(uid);
      for (int id in userLikes.likes) {
        final response =
            await Dio().get('http://waco-api.herokuapp.com/api/posts/$id');
        Map<String, dynamic> data = json.decode(response.toString());
        var publication = data['data'];
        pubs.add(Publication(
            id: publication['id'],
            title: publication['title'],
            body: publication['body'],
            userId: publication['user'],
            link: publication['link'],
            favorite: true));
      }
    } catch (e) {
      debugPrint(e.toString());
      return pubs;
    }
    return pubs;
  }
}
