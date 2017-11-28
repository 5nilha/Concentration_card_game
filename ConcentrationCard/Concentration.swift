//
//  Concentration.swift
//  ConcentrationCard
//
//  Created by Fabio Quintanilha on 11/28/17.
//  Copyright © 2017 Fabio Quintanilha. All rights reserved.
//


//Controller
import Foundation

class Concentration {
    
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard : Int?
    
    init (numberOfPairsOfCard: Int) {
        for _ in 1...numberOfPairsOfCard {
            let card = Card()
            
            //Should append two similar cards to mach the cards
            cards.append(card)
            cards.append(card)
//            cards += [card, card]
        }
    }
    
    
    func chooseACard(at index: Int){
        
        if !(cards[index].isMatched) {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //Check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }
            else {
                //Either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    //Suffle the cards in a random order
    func shuffleCards(){
        var shuffleCard = [Card]()
        
        for _ in cards {
            
            let index = Int(arc4random_uniform(UInt32(cards.count)))
            shuffleCard.append(cards[index])
            cards.remove(at: index)
        }
        
        cards.append(contentsOf: shuffleCard)
    }
    
}

