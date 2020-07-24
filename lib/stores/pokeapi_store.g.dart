// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokeapi_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PokeApiStore on _PokeApiStoreBase, Store {
  Computed<Pokemon> _$currentPokemonComputed;

  @override
  Pokemon get currentPokemon => (_$currentPokemonComputed ??=
          Computed<Pokemon>(() => super.currentPokemon))
      .value;

  final _$pokeAPIAtom = Atom(name: '_PokeApiStoreBase.pokeAPI');

  @override
  PokeAPI get pokeAPI {
    _$pokeAPIAtom.context.enforceReadPolicy(_$pokeAPIAtom);
    _$pokeAPIAtom.reportObserved();
    return super.pokeAPI;
  }

  @override
  set pokeAPI(PokeAPI value) {
    _$pokeAPIAtom.context.conditionallyRunInAction(() {
      super.pokeAPI = value;
      _$pokeAPIAtom.reportChanged();
    }, _$pokeAPIAtom, name: '${_$pokeAPIAtom.name}_set');
  }

  final _$_currentPokemonAtom = Atom(name: '_PokeApiStoreBase._currentPokemon');

  @override
  Pokemon get _currentPokemon {
    _$_currentPokemonAtom.context.enforceReadPolicy(_$_currentPokemonAtom);
    _$_currentPokemonAtom.reportObserved();
    return super._currentPokemon;
  }

  @override
  set _currentPokemon(Pokemon value) {
    _$_currentPokemonAtom.context.conditionallyRunInAction(() {
      super._currentPokemon = value;
      _$_currentPokemonAtom.reportChanged();
    }, _$_currentPokemonAtom, name: '${_$_currentPokemonAtom.name}_set');
  }

  final _$_PokeApiStoreBaseActionController =
      ActionController(name: '_PokeApiStoreBase');

  @override
  dynamic fetchPokemonList() {
    final _$actionInfo = _$_PokeApiStoreBaseActionController.startAction();
    try {
      return super.fetchPokemonList();
    } finally {
      _$_PokeApiStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getPokemon({int index}) {
    final _$actionInfo = _$_PokeApiStoreBaseActionController.startAction();
    try {
      return super.getPokemon(index: index);
    } finally {
      _$_PokeApiStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCurrentPokemon({int index}) {
    final _$actionInfo = _$_PokeApiStoreBaseActionController.startAction();
    try {
      return super.setCurrentPokemon(index: index);
    } finally {
      _$_PokeApiStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Widget getImage({String number}) {
    final _$actionInfo = _$_PokeApiStoreBaseActionController.startAction();
    try {
      return super.getImage(number: number);
    } finally {
      _$_PokeApiStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'pokeAPI: ${pokeAPI.toString()},currentPokemon: ${currentPokemon.toString()}';
    return '{$string}';
  }
}
