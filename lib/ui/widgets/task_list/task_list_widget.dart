import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_forge/ui/widgets/task_list/cubits/task_list_cubit.dart';
import 'package:focus_forge/ui/widgets/task_list/states/task_list_state.dart';
import 'package:focus_forge/ui/widgets/task_list/widgets/task_tile.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({
    super.key,
    this.isSliver = false,
  });

  final bool isSliver;

  @override
  Widget build(BuildContext context) {
    if (isSliver) {
      return BlocBuilder<TaskListCubit, TaskListState>(
        builder: (context, state) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index >= state.tasks.length) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: LinearProgressIndicator(),
                    ),
                  );
                }
                return ListTile(
                  leading: Text('${index + 1}'),
                  title: Text(state.tasks[index].name),
                  onTap: () {},
                );
              },
              childCount:
                  state.loading ? state.tasks.length + 1 : state.tasks.length,
            ),
          );
        },
      );
    }
    return BlocBuilder<TaskListCubit, TaskListState>(
      builder: (context, state) {
        return ListView.builder(
          controller: context.read<TaskListCubit>().scrollController,
          itemCount:
              state.loading ? state.tasks.length + 1 : state.tasks.length,
          itemBuilder: (context, index) {
            if (index >= state.tasks.length) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: LinearProgressIndicator(),
                ),
              );
            }
            return TaskTile(task: state.tasks[index], index: index);
          },
        );
      },
    );
  }
}
