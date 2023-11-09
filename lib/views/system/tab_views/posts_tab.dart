import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class PostsTab extends ConsumerStatefulWidget {
  const PostsTab({
    super.key,
    required this.constraints,
  });

  final BoxConstraints constraints;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostsTabState();
}

class _PostsTabState extends ConsumerState<PostsTab> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
