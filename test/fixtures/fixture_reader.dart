import 'dart:io';

String fixture(String name) => File('test/fixtures/$name').readAsStringSync();

const characterFixture = 'character.json';
const characterSearchFixture = 'character_search.json';
const characterSearchInfoFixture = 'character_search_info.json';
const episodeFixture = 'episode.json';
