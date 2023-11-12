class Wallpaper {
  int? id;
  String? originalSize;
  String? largeSize;
  String? mediumSize;

  Wallpaper.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    originalSize = json['src']['original'];
    largeSize = json['src']['large2x'];
    mediumSize = json['src']['medium'];
  }

  Wallpaper.fromDatabase(Map<String, dynamic> json) {
    id = json['id'];
    originalSize = json['original'];
    largeSize = json['large2x'];
    mediumSize = json['medium'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'original': originalSize,
      'large2x': largeSize,
      'medium': mediumSize,
    };
  }
}
