import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolly_podcast/core/constants/utils.dart';
import 'package:jolly_podcast/features/podcasts/presentation/bloc/pod_bloc.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  void initState() {
    getPodCasts();
    super.initState();
  }

  void getPodCasts() async {
    debugPrint('FETCHING PODCASTS IN DISCOVER PAGE');
    // await context.read<PodBloc>().getPods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.secondary,
      body: Center(child: Text('DISCOVER PAGE')),
    );
  }
}
