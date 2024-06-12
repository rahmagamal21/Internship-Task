import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/Features/Home/Presentation/Controller/cubit/repos_request_cubit.dart';
import 'package:task/Features/Home/Presentation/Widgets/card.dart';

import '../widgets/divider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: BlocBuilder<ReposRequestCubit, ReposRequestState>(
            builder: (context, state) {
              if (state is ReposRequestLoading) {
                return const CircularProgressIndicator();
              } else if (state is ReposRequestSuccess) {
                final repositories = state.repositories;
                return ListView.separated(
                  itemBuilder: (context, index) {
                    final repository = repositories[index];

                    return CustomCard(
                      title: repository.name,
                      subTitle: repository.description,
                      trailing: repository.ownerName,
                      isForked: repository.isForked,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const CustomDivider();
                  },
                  itemCount: repositories.length,
                );
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
        ),
      ),
    );
  }
}
