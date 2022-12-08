//
//  DisneyHero.swift
//  DisneyApiAppWithAF
//
//  Created by Denis Kukushkin on 08.12.2022.
//

struct Disney: Decodable {
    let data: [DisneyHero]
    let count: Int?
    let totalPages: Int?
    let nextPage: String?
    let previousPage: String?
}
    
struct DisneyHero: Decodable {
    let name: String?
    let imageUrl: String?
    let url: String?
    var films: [String]?
    let shortFilms: [String]?
    let tvShows: [String]?
    let videoGames: [String]?
    let parkAttractions: [String]?
    let allies: [String]?
    let enemies: [String]?
    
    var description: String? {
        """
        Name: \(name ?? "No data 🙃")
        Films: \(withoutBrackets(in: films))
        Short Films: \(withoutBrackets(in: shortFilms))
        Tv Shows: \(withoutBrackets(in: tvShows))
        VideoGames: \(withoutBrackets(in: videoGames))
        Park Attractions: \(withoutBrackets(in: parkAttractions))
        Allies: \(withoutBrackets(in: allies))
        Enemies: \(withoutBrackets(in: enemies))
        """
    }

}

enum Link: String {
    case disneyAPI = "https://api.disneyapi.dev/characters"
}


extension DisneyHero {
    
    private func withoutBrackets(in heroDetails: [String]?) -> String {
        var allValues = ""
        guard let heroDetails = heroDetails else { return ""}
        
        if heroDetails.isEmpty {
            return "No data 🙃"
        }
        
        for value in heroDetails {
            if value != heroDetails.last {
                allValues += "\(value), "
            } else {
                allValues += value
            }
        }
        return allValues
    }
}
