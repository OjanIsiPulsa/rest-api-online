import 'package:flutter/material.dart';

import '../models/news_model.dart';

class NewsDetailPage extends StatelessWidget {
  const NewsDetailPage({super.key, required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          key: const ValueKey('news-detail-back'),
          tooltip: 'Kembali',
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('News App'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (news.imageUrl.isNotEmpty)
              Image.network(
                news.imageUrl,
                width: double.infinity,
                height: 240,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const _DetailImagePlaceholder(),
              )
            else
              const _DetailImagePlaceholder(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.category.isEmpty ? 'Tanpa kategori' : news.category,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    news.title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    news.author.isEmpty
                        ? 'Penulis tidak diketahui'
                        : 'Oleh ${news.author}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Divider(height: 32),
                  Text(
                    news.content.isEmpty
                        ? 'Konten berita belum tersedia.'
                        : news.content,
                    style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailImagePlaceholder extends StatelessWidget {
  const _DetailImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 220,
      child: ColoredBox(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: const Center(
          child: Icon(Icons.image_not_supported_outlined, size: 48),
        ),
      ),
    );
  }
}
