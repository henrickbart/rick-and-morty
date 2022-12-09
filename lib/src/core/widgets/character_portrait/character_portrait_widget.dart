import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../modules/characters/domain/entities/character.dart';

class CharacterPortraitWidget extends StatelessWidget {
  final Character character;
  const CharacterPortraitWidget({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.favorite),
                color: character.isFavorite ? Colors.red : Colors.grey,
                onPressed: () {},
              )),
          SizedBox(
              height: 80,
              width: 80,
              child: ExtendedImage.network(
                character.image,
                fit: BoxFit.cover,
                cache: true,
              )),
          Text(character.name, style: const TextStyle(fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis)),
          Text(character.species, overflow: TextOverflow.ellipsis),
          Text('${character.episodes.length} episodes', overflow: TextOverflow.ellipsis),
        ],
      ),
    );
    // return BlocProvider(
    //   create: (context) => serviceLocator<CharacterPortraitCubit>(),
    //   child: Card(
    //       child: Column(
    //     children: [
    //       Align(
    //         alignment: Alignment.centerRight,
    //         child: BlocConsumer<CharacterPortraitCubit, CharacterPortraitState>(
    //           listener: (context, state) {
    //             if (state is ErrorState) {
    //               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
    //             } else if (state is LoadedState) {
    //               //BlocProvider.of<characterListBloc.CharacterListBloc>(context).add(characterListBloc.ToogleFavoriteEvent(character: character));
    //             }
    //           },
    //           builder: (context, state) {
    //             var color = character.isFavorite ? Colors.red : Colors.grey;

    //             if (state is LoadingState) {
    //               return const CircularProgressIndicator();
    //             } else if (state is LoadedState) {
    //               color = (state).isFavorite ? Colors.red : Colors.grey;
    //             }
    //             return IconButton(
    //               icon: const Icon(Icons.favorite),
    //               color: color,
    //               onPressed: () => context.read<CharacterPortraitCubit>().toggleFavorite(character),
    //             );
    //           },
    //         ),
    //       ),
    //       SizedBox(
    //           height: 80,
    //           width: 80,
    //           child: ExtendedImage.network(
    //             character.image,
    //             fit: BoxFit.cover,
    //             cache: true,
    //           )),
    //       Text(character.name, style: const TextStyle(fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis)),
    //       Text(character.species, overflow: TextOverflow.ellipsis),
    //       Text('${character.episodes.length} episodes', overflow: TextOverflow.ellipsis),
    //     ],
    //   )),
    // );
  }
}
