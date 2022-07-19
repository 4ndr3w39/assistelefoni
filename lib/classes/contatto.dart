class Contact {
  final String birthday;
  final int id;
  final String name;
  final String nickname;
  final String url;
  final String thumbnailUrl;

  const Contact({
    required this.birthday,
    required this.nickname,
    required this.id,
    required this.name,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      birthday: json['birthday'] as String,
      nickname: json['nickname'] as String,
      id: json['char_id'] as int,
      name: json['name'] as String,
      url: json['img'] as String,
      thumbnailUrl: json['img'] as String,
    );
  }
}
