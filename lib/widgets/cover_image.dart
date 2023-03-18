import 'package:flutter/material.dart';

class CoverImage extends StatelessWidget {
  final String imageUrl;

  const CoverImage({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  bool isValidUrl(String url) {
    return Uri.tryParse(url)?.hasAbsolutePath == true;
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (isValidUrl(imageUrl)) {
      imageWidget = Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const SizedBox(),
      );
    } else {
      imageWidget = Container(
        color: Colors.grey.shade200,
        child: const Center(
          child: Icon(
            Icons.book,
            color: Colors.grey,
            size: 48,
          ),
        ),
      );
    }

    return imageWidget;
  }
}
