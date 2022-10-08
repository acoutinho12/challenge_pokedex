//
//  PokemonMockHelpers.swift
//  PokedexTests
//
//  Created by André Luis Barbosa Coutinho on 08/10/22.
//

import Foundation
@testable import Pokedex

struct PokemonMockHelpers {
    let pokemonResult = [PokemonResult(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")]
    let species = Species(name: "chlorophyll", url: "https://pokeapi.co/api/v2/ability/34/")
    let pokemonSpecies = PokemonSpecies(evolutionChain: nil)

    let ability: Ability
    let gameIndex: GameIndex
    let heldItem: HeldItem
    let versionDetail: VersionDetail
    let move: Move
    let pokemonMock: Pokemon
    let pokemonDetails: PokemonDetails
    let pokemonAbilityDetails: PokemonAbilityDetails
    let pokemonEvolutionChain: PokemonEvolutionChain
    let chain: Chain

    init() {
        pokemonMock = Pokemon(count: 1154, next: "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20", previous: nil, results: pokemonResult)
        ability = Ability(ability: species, isHidden: false, slot: 1)
        gameIndex = GameIndex(gameIndex: 1, version: species)
        versionDetail = VersionDetail(rarity: 1, version: species)
        heldItem = HeldItem(item: species, versionDetails: [versionDetail])
        move = Move(move: species, versionGroupDetails: [])
        chain = Chain(evolutionDetails: [], evolvesTo: [], isBaby: false, species: species)

        pokemonDetails = PokemonDetails(abilities: [ability], baseExperience: 1, forms: [species], gameIndices: [gameIndex], height: 100, heldItems: [heldItem], id: 1,
                                        isDefault: true, locationAreaEncounters: "https://pokeapi.co/api/v2/pokemon/1/encounters",
                                        moves: [move], name: "bulbasaur", order: 1, species: species, sprites: nil, stats: nil, types: nil,
                                        weight: 100)

        pokemonAbilityDetails = PokemonAbilityDetails(effectChanges: [], effectEntries: [], flavorTextEntries: [], generation: nil, id: 1, isMainSeries: true, name: "overgrow",
                                                      names: [], pokemon: [])

        pokemonEvolutionChain = PokemonEvolutionChain(chain: chain, id: 1)
    }
}
