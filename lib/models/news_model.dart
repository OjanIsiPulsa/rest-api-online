class News {
  const News({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.category,
    required this.author,
    this.createdAt,
  });

  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final String category;
  final String author;
  final DateTime? createdAt;

  factory News.fromJson(Map<String, dynamic> json) {
    final createdAtValue = json['cratedAt'] ?? json['createdAt'];
    final createdAt = createdAtValue == null || createdAtValue == ''
        ? null
        : DateTime.tryParse(_requiredString(createdAtValue, 'cratedAt'));

    return News(
      id: _requiredString(json['id'], 'id'),
      title: _requiredString(json['title'], 'title'),
      content: _optionalString(json['content']),
      imageUrl: _optionalString(json['image_url']),
      category: _optionalString(json['category']),
      author: _optionalString(json['author']),
      createdAt: createdAt,
    );
  }

  static String _requiredString(Object? value, String field) {
    if (value is String) return value;
    if (value is num) return value.toString();
    throw FormatException('Field "$field" tidak berisi teks yang valid.');
  }

  static String _optionalString(Object? value) {
    if (value == null) return '';
    if (value is String) return value;
    if (value is num) return value.toString();
    throw const FormatException(
      'Data berita memiliki field teks yang tidak valid.',
    );
  }
}
