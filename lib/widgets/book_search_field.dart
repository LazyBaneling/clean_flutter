import 'package:flutter/material.dart';

class BookSearchField extends StatelessWidget with PreferredSizeWidget {
  const BookSearchField({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search for a book by title',
            style: textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w100,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: 'Book title',
              hintStyle: textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w100,
              ),
              prefixIcon: const Icon(Icons.search),
              border: InputBorder.none,
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceVariant,
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
