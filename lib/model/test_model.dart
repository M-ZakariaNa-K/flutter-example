// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Products {
  String title;
  num price;
  String thumbnail;
  Products({
    required this.title,
    required this.price,
    required this.thumbnail,
  });

  Products copyWith({
    String? title,
    num? price,
    String? thumbnail,
  }) {
    return Products(
      title: title ?? this.title,
      price: price ?? this.price,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'price': price,
      'thumbnail': thumbnail,
    };
  }

  factory Products.fromMap(Map<String, dynamic> map) {
    return Products(
      title: map['title'] as String,
      price: map['price'] as num,
      thumbnail: map['thumbnail'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Products.fromJson(String source) => Products.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Products(title: $title, price: $price, thumbnail: $thumbnail)';

  @override
  bool operator ==(covariant Products other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.price == price &&
      other.thumbnail == thumbnail;
  }

  @override
  int get hashCode => title.hashCode ^ price.hashCode ^ thumbnail.hashCode;
}
