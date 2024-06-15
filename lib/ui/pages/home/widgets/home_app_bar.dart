import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:focus_forge/app/cubits/app_cubit.dart';
import 'package:focus_forge/app/states/app_state.dart';
import 'package:focus_forge/src/user/domain/user.dart';
import 'package:focus_forge/ui/widgets/task_list/cubits/task_list_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: ListTile(
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.bars),
          onPressed: () {},
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {},
              icon: BlocSelector<AppCubit, AppState, User?>(
                selector: (state) => state.user,
                builder: (context, user) {
                  if (user?.photoURL == null) return const CircleAvatar();
                  return CircleAvatar(
                    backgroundImage: NetworkImage(user!.photoURL!),
                  );
                },
              ),
            ),
          ],
        ),
        tileColor: Colors.amber,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),
      bottom: TabBar(
        onTap: (value) {
          final TaskListCubit cubit = context.read<TaskListCubit>();
          if (value == 0) cubit.changeIsDone(false);
          if (value == 1) cubit.changeIsDone(true);
        },
        tabs: [
          Tab(
            text: AppLocalizations.of(context)!.pending,
          ),
          Tab(
            text: AppLocalizations.of(context)!.completed,
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize {
    final double bottomHeight = const TabBar(
      tabs: [
        Tab(text: ''),
        Tab(text: ''),
      ],
    ).preferredSize.height;
    return Size.fromHeight(kToolbarHeight + bottomHeight);
  }
}
