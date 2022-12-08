//
//  DisneyHero.swift
//  DisneyApiAppWithAF
//
//  Created by Denis Kukushkin on 08.12.2022.
//

struct Disney: Decodable {
    let data: [DisneyHero]
    let count: Int
    let totalPages: Int
    let nextPage: String
    let previousPage: String?
    
    init(disney: [String: Any]) {
        let disneyHeroes = disney["data"] as! [[String: Any]]
        data = DisneyHero.getDisneyHeroes(from: disneyHeroes)
        count = disney["count"] as! Int
        totalPages = disney["totalPages"] as! Int
        nextPage = disney["nextPage"] as! String
        previousPage = disney["previousPage"] as? String ?? ""
    }
    
    static func getDisney(from value: Any) -> Disney {
        guard let disneyData = value as? [String: Any] else { return Disney(disney: [:]) }
        let disney = Disney(disney: disneyData)
        return disney
    }
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

    init(disneyHero: [String: Any]) {
        name = disneyHero["name"] as? String
        imageUrl = disneyHero["imageUrl"] as? String
        url = disneyHero["url"] as? String
        films = disneyHero["films"] as? [String]
        shortFilms = disneyHero["shortFilms"] as? [String]
        tvShows = disneyHero["tvShows"] as? [String]
        videoGames = disneyHero["videoGames"] as? [String]
        parkAttractions = disneyHero["parkAttractions"] as? [String]
        allies = disneyHero["allies"] as? [String]
        enemies = disneyHero["enemies"] as? [String]
    }

    static func getDisneyHeroes(from value: Any) -> [DisneyHero] {
        guard let disneyHeroesData = value as? [[String: Any]] else { return [] }
        return disneyHeroesData.compactMap { DisneyHero(disneyHero: $0) }

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
