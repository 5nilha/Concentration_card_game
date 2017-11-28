//
//  Card.swift
//  ConcentrationCard
//
//  Created by Fabio Quintanilha on 11/28/17.
//  Copyright © 2017 Fabio Quintanilha. All rights reserved.
//

import Foundation

//Model
struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identitierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identitierFactory += 1
        return identitierFactory
    }
    
    init () {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    
    
}
