class Publication {
  int id;
  String title;
  String body;
  String userId;
  String link;
  bool favorite;

  bool get getFavorite => favorite;

  set setFavorite(bool favorite) => this.favorite = favorite;

  String get getLink => link;

  set setLink(String link) => this.link = link;

  int get getId => id;

  set setId(int id) => this.id = id;

  get getTitle => title;

  set setTitle(title) => this.title = title;

  get getBody => body;

  set setBody(body) => this.body = body;

  get getUserId => userId;

  set setUserId(userId) => this.userId = userId;

  Publication({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    required this.link,
    this.favorite = false,
  });
}
