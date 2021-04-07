//
//  PokeApiListResult.swift
//  pokedex
//
//  Created by Admin on 4/5/21.
//

import Foundation

// MARK: - Welcome
struct PokeApiListResult: Codable {
    let count: Int?
    let next: String?
    let previous: JSONNull?
    let results: [PokemonRow]?
    
    func toPokemonArray() -> [Pokemon]? {
        return self.results?.map{
            return Pokemon(id: $0.id, name: $0.name, imageUrl: $0.imageUrl)
        }
    }
}

// MARK: - Result
struct PokemonRow: Codable {
    let name: String?
    let url: String?
    var id: Int? {
        if let safeUrl = url {
            let pathParts = safeUrl.split(separator: "/")
            if let stringId = pathParts.last{
                return Int(stringId)
            }
            return nil
        }
        return nil
    }
    var imageUrl:String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id ?? 0).png";
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
