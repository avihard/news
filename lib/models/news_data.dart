class RssData {
  String title;
  String link;
  String guid;
  String comments;
  String description;
  List<String> category;
  Title creator;
  String pubDate;
  String identifier;
  String url;
  int like_count;
  int dislike_count;

  RssData(
      {this.title,
      this.link,
      this.guid,
      this.comments,
      this.description,
      this.category,
      this.creator,
      this.pubDate,
      this.identifier,
      this.url,
      this.like_count,
      this.dislike_count});

  RssData.fromJson(Map<dynamic, dynamic> json) {
    title = json['title'];
    link = json['link'];
    guid = json['guid'];
    comments = json['comments'];
    description = json['description'];
    category = json['category'].cast<String>();
    creator =
        json['creator'] != null ? new Title.fromJson(json['creator']) : null;
    pubDate = json['pubDate'];
    identifier = json['identifier'];
    like_count = json['like_count'];
    dislike_count = json['dislike_count'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['link'] = this.link;
    data['guid'] = this.guid;
    data['comments'] = this.comments;
    data['description'] = this.description;
    data['category'] = this.category;
    if (this.creator != null) {
      data['creator'] = this.creator.toJson();
    }
    data['pubDate'] = this.pubDate;
    data['identifier'] = this.identifier;
    data['url'] = this.url;
    data['dislike_count'] = this.dislike_count;
    data['like_count'] = this.like_count;
    return data;
  }
}

class Title {
  String sCdata;

  Title({this.sCdata});

  Title.fromJson(Map<String, dynamic> json) {
    sCdata = json['__cdata'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__cdata'] = this.sCdata;
    return data;
  }
}
