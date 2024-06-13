import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:task/Features/Home/Presentation/Controller/cubit/repos_request_cubit.dart';
import '../Widgets/home_view_body.dart';
import '../Widgets/search_field.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                CustomSearchField(
                  searchController: searchController,
                ),
                const SizedBox(
                  height: 15,
                ),
                BlocBuilder<ReposRequestCubit, ReposRequestState>(
                  builder: (context, state) {
                    if (state is ReposRequestLoading ||
                        state is ReposRequestMoreSuccess) {
                      return const CircularProgressIndicator();
                    } else if (state is ReposRequestSuccess) {
                      final repositories = state.repositories;
                      return HomeBody(repositories: repositories);
                    } else if (state is ReposRequestFailure) {
                      return Center(
                        child: Text(
                            'Failed to fetch repositories:\n${state.errorMessage}'),
                      );
                    } else {
                      return const Text('Something went wrong!');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
