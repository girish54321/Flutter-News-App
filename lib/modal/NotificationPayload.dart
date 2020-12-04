// // class NotificationPayload {
// //   final String title;
// //   final String message;
// //   final String imageUrl;

// //   NotificationPayload(this.title, this.message, this.imageUrl);
// // }
class NotificationPayload {
  NotificationPayload({
    this.body,
    this.title,
    this.imageUrl,
    this.link,
  });

  String body;
  String title;
  String imageUrl;
  String link;

  factory NotificationPayload.fromJson(Map<String, dynamic> json) =>
      NotificationPayload(
        body: json["body"] == null ? null : json["body"],
        title: json["title"] == null ? null : json["title"],
        imageUrl: json["image_url"] == null ? null : json["image_url"],
        link: json["link"] == null ? null : json["link"],
      );

  Map<String, dynamic> toJson() => {
        "body": body == null ? null : body,
        "title": title == null ? null : title,
        "image_url": imageUrl == null ? null : imageUrl,
        "link": link == null ? null : link,
      };
}
