import 'package:flutter/material.dart';
import 'package:flutter_arc/features/posts/presentation/block/posts/posts_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/posts/presentation/block/add_delete_update_post_bloc/add_delete_update_post_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:  (_)=> di.sl<PostsBloc>(),),
        BlocProvider(create: (_)=>di.sl<AddDeleteUpdatePostBloc>())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
