import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/comment_bloc.dart';
import '../widgets/widgets.dart';


class CommentList extends StatefulWidget {
  const CommentList({super.key});

  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        switch (state.status) {
          case CommentStatus.failure:
            return const Center(child: Text('ошибка загрузки данных о комментариях'));
          case CommentStatus.success:
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.comments.length
                    ? const BottomLoader()
                    : CommentItem(comment: state.comments[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.comments.length
                  : state.comments.length + 1,
              controller: _scrollController,
            );
          case CommentStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<CommentBloc>().add(CommentFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}