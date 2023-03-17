import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.onTap,
    required this.heroTag,
  }) : super(key: key);

  final String imageUrl;
  final String title;
  final VoidCallback onTap;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w300),
                ),
              ),
              if (imageUrl != '')
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width / 2,
                  ),
                  child: Hero(
                    tag: heroTag,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      height: 160,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
