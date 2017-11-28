//
//  ViewController.swift
//  ConcentrationCard
//
//  Created by Fabio Quintanilha on 11/27/17.
//  Copyright © 2017 Fabio Quintanilha. All rights reserved.
//


//View
import UIKit

class ViewController: UIViewController {

    // using Lazy, it does not initialize until someone tries to use game. Lazy cannot have a did set.
    lazy var game = Concentration(numberOfPairsOfCard: (cardButtons.count + 1) / 2) // we add by one because if the numbers of button is odd we never get the odd number in the division. divide by 2 because every card should be duplicated to match with each other
    
    //Everytime the variable FlipCount changes, it will call the didSet
    var flipCount: Int = 0 { didSet { flipCountLabel.text = "Flips: \(flipCount)" } }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    //Outlet Collection - > Array of UIButton. All buttons are connected to this array
    @IBOutlet var cardButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game.shuffleCards()
    }

    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        //CardButtons is an array of buttons created above
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseACard(at: cardNumber)
//            flipCard(withEmoji: emojiImages[cardNumber], on: sender)
            updateViewFromModel()
        }
    
    }
    
    func updateViewFromModel() {
        //Indices is a method in array that return a countable range of all index in the array
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for : card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else {
                if card.isMatched {
                    button.setTitle("", for: .normal)
                    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                    button.isHidden = true
                }
                else {
                    button.setTitle("", for: .normal)
                    button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                }
            }
        }
    }
    
    
    var emojiImages: Array<String> = ["🎃","👻","💀", "👹", "☠️", "👾", "😈", "👺", "🧛🏻‍♀️", "👿", "👽", "🧟‍♀️", "🧙🏾‍♂️", "🧙‍♀️"]
    var emoji = [Int : String]() //Dictionary
    
    
    func emoji(for card: Card) -> String {
        
        if emoji[card.identifier] == nil, emojiImages.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiImages.count)))
            emoji[card.identifier] = emojiImages.remove(at: randomIndex)
        }

             return emoji[card.identifier]!
    }
}

