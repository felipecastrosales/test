import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubits/board_cubit.dart';
import 'package:todo/pages/board_page.dart';
import 'package:todo/repositories/board_repository.dart';
import 'package:todo/repositories/isar/isar_board_repository.dart';
import 'package:todo/repositories/isar/isar_datasource.dart';

void main() {
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider(
          create: (context) => IsarDatasource(),
        ),
        RepositoryProvider<BoardRepository>(
          create: (context) => IsarBoardRepository(datasource: context.read()),
        ),
        BlocProvider(
          create: (context) => BoardCubit(repository: context.read()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.purple,
        ),
        home: const BoardPage(),
      ),
    );
  }
}
