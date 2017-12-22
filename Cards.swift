//
//  Cards.swift
//  AC-iOS-MidUnit4Assessment-StudentVersion
//
//  Created by C4Q on 12/22/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct CardDeck: Codable {
    let shuffled: Bool
    let deck_id: String
    let remaining: Int
}

/***************************/

struct RandomCard: Codable {
    let cards: [Card]
}

struct Card: Codable {
    let code: String
    let image: URL
    var value: String
}

struct CardDeckAPIClient {
    private init() {}
    static let manager = CardDeckAPIClient()
    func getDecks(completionHandler: @escaping (CardDeck) -> Void,
                  errorHandler: @escaping (Error) -> Void) {
        let urlStr = "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=6"
        let request = URLRequest(url: URL(string: urlStr)!)
        let parsePixabay: (Data) -> Void = {(data: Data) in
            do {
                let deckInfo = try JSONDecoder().decode(CardDeck.self, from: data)
                completionHandler(deckInfo)
            }
            catch {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: request, completionHandler: parsePixabay, errorHandler: errorHandler)
    }
}

struct RandomCardAPIClient {
    private init() {}
    static let manager = RandomCardAPIClient()
    func getCard(from deck: String,
                 completionHandler: @escaping (Card) -> Void,
                 errorHandler: @escaping (Error) -> Void) {
        let urlStr = "https://deckofcardsapi.com/api/deck/\(deck)/draw/?count=1"
        let request = URLRequest(url: URL(string: urlStr)!)
        let parsePixabay: (Data) -> Void = {(data: Data) in
            do {
                let cardInfo = try JSONDecoder().decode(RandomCard.self, from: data)
                completionHandler(cardInfo.cards.first!)
            }
            catch {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: request, completionHandler: parsePixabay, errorHandler: errorHandler)
    }
}


