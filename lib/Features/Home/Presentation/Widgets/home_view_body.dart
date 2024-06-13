import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/Features/Home/Presentation/Widgets/card.dart';
import 'package:task/Features/Home/Presentation/Widgets/divider.dart';

import '../../Data/Data Model/repo_model.dart';
import '../Controller/cubit/repos_request_cubit.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({
    super.key,
    required this.repositories,
  });

  final List<GitHubRepository> repositories;

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  late ScrollController scrollController = ScrollController();
  late List<GitHubRepository> displayedRepositories;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    displayedRepositories = List.from(widget.repositories);
    scrollController = ScrollController()..addListener(scrollListener);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (!isLoadingMore) {
        isLoadingMore = true;
        BlocProvider.of<ReposRequestCubit>(context).fetchMoreRepositories();
      }
    }
  }

  void loadMoreRepositories(List<GitHubRepository> repositories) {
    setState(() {
      displayedRepositories.addAll(repositories);
      isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        controller: scrollController,
        itemCount: widget.repositories.length,
        itemBuilder: (context, index) {
          if (index < displayedRepositories.length) {
            final repository = displayedRepositories[index];
            return CustomCard(
              title: repository.name,
              subTitle: repository.description,
              trailing: repository.ownerName,
              isForked: repository.isForked,
              ownerLink: repository.ownerLink,
              repoLink: repository.repoLink,
            );
          } else {
            return buildLoaderIndicator();
          }
        },
        separatorBuilder: (context, index) {
          return const CustomDivider();
        },
      ),
    );
  }

  Widget buildLoaderIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
