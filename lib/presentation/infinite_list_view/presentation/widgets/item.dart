

import 'package:flutter/material.dart';
import 'package:test_ososs/presentation/infinite_list_view/model.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({key, this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: Text('${post.id}', style: textTheme.bodySmall),
        title: Text(post.title),
        isThreeLine: true,
        subtitle: Text(post.body),
        dense: true,
      ),
    );
  }
}