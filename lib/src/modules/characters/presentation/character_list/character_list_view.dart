import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/dependency_injection.dart';
import 'package:rick_and_morty/src/modules/characters/presentation/character_list/bloc/character_list_bloc.dart';

import '../../../../core/widgets/character_portrait/character_portrait_widget.dart';

class CharacterListView extends StatelessWidget {
  const CharacterListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rick and Morty')),
      body: BlocProvider(
        create: (context) => serviceLocator<CharacterListBloc>()..add(const GetCharactersEvent()),
        child: BlocBuilder<CharacterListBloc, CharacterListState>(
          builder: (context, state) {
            if (state is InitialState) {
              return const Center(child: Text('Initial'));
            } else if (state is EmptyState) {
              return Center(child: Text(state.message));
            } else if (state is LoadingState) {
              if (state.characters.isNotEmpty) {
                return ListViewCharacters(
                  state: state,
                );
              }
              return const Center(child: CircularProgressIndicator());
            } else if (state is LoadedState) {
              return ListViewCharacters(
                state: state,
              );
            } else if (state is ErrorState) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}

class ListViewCharacters extends StatefulWidget {
  ListViewCharacters({Key? key, required this.state}) : super(key: key);

  final DataState state;
  final ScrollController _scrollController = ScrollController();

  @override
  State<ListViewCharacters> createState() => _ListViewCharactersState();
}

class _ListViewCharactersState extends State<ListViewCharacters> {
  @override
  void dispose() {
    widget._scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      controller: widget._scrollController
        ..addListener(() {
          if (widget.state is LoadedState) {
            var nextPageTrigger = 0.8 * widget._scrollController.position.maxScrollExtent;

            if (widget._scrollController.position.pixels > nextPageTrigger) {
              context.read<CharacterListBloc>().add(const GetCharactersEvent());
            }
          }
        }),
      itemCount: widget.state.characters.length + (widget.state is LoadingState ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == widget.state.characters.length) {
          return const Center(child: CircularProgressIndicator());
        }
        final character = widget.state.characters[index];
        return CharacterPortraitWidget(character: character);
      },
    );
  }
}
