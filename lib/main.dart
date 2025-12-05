import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Features/home/presentation/pages/home.dart';
import 'features/walkthrough/presentation/bloc/walkthrough_bloc.dart';
import 'features/walkthrough/presentation/pages/walkthrough_page.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => WalkthroughBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WalletScreen(),
      ),
    ),
  );
}
