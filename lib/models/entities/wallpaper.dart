class Wallpaper {
  int? id;
  String? originalSize;
  String? mediumSize;

  Wallpaper.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    originalSize = json['src']['original'];
    mediumSize = json['src']['medium'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'src': {
        'original': originalSize,
        'medium': mediumSize,
      }
    };
  }
}
