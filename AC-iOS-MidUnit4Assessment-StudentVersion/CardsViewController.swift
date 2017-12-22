//
//  ViewController.swift
//  AC-iOS-MidUnit4Assessment-StudentVersion
//
//  Created by C4Q  on 12/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    
    @IBOutlet weak var countLabel: UILabel!
    
    var deck: CardDeck?

    var cards = [Card]()
    
    var num = 0
    
    var counter = 0 {
        didSet {
            if counter < oldValue {
                cardsCollectionView.reloadData()
            }
        }
    }
    
    var formattedValues = [Int]() {
        didSet {
            print()
            print(formattedValues)
        }
    }
    
    @IBOutlet weak var cardsCollectionView: UICollectionView!
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        showAlert()
    }
    
    @IBAction func drawCardButtonPressed(_ sender: UIButton) {
        //Make API CALL
        getNextCard(from: (deck?.deck_id)!)
        counter += 1
        if num >= 30 {
            self.showAlert()
        }
        countLabel.text = "Current Count: \(num)"
    }
    
    func resetGame() {
        num = 0
        counter = 0
        cards = []
        formattedValues = []
        saveToHistory()
        countLabel.text = "Current Count: 0"
    }
    
    func showAlert() {
        let awayFrom30 = 30 - num
        let alert = UIAlertController(title: "Game", message: "You were \(awayFrom30) away from 30!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Reset", style: .destructive) {UIAlertAction in
            self.saveToHistory()
            self.resetGame()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func formatValues(for cards: String) -> Int {
        var temp = 0
        switch cards {
        case "JACK", "QUEEN","KING":
            temp = 10
        case "ACE":
            temp = 11
        default:
            temp = Int(cards)!
        }
        return temp
    }
    
    func getDeck(){
        CardDeckAPIClient.manager.getDecks(completionHandler: {self.deck = $0},
                                           errorHandler: {print($0)})
    }
    
    func getNextCard(from deck: String) {
        let completion = {(onlineCard: Card) in
            self.cards.append(onlineCard)
            self.formattedValues.append(self.formatValues(for: onlineCard.value))
            self.cardsCollectionView.reloadData()
        }
        RandomCardAPIClient.manager.getCard(from: deck,
                                            completionHandler: completion,
                                            errorHandler: {print($0)})
    }
    
    
    func saveToHistory() {
        let newSave = RecentData.init(values: formattedValues)
        DataModel.shared.addFavoritesItemToList(favoriteItem: newSave)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardsCollectionView.dataSource = self
        cardsCollectionView.delegate = self
        //        let nib = UINib(nibName: "HistoryCellView", bundle: nil)
        //        self.cardsCollectionView.register(nib, forCellWithReuseIdentifier: "Card Cell")
        getDeck()
        countLabel.text = "Current Count: 0"
    }
}

extension CardsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //RETURN NUM CELLS = COUNTER
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cardsCollectionView.dequeueReusableCell(withReuseIdentifier: "Card Cell", for: indexPath) as! CardCollectionViewCell
        let card = cards[indexPath.row]
        let value = formattedValues[indexPath.row]
        print("/////////////////////")
        cell.cardLabel.text = String(value)
        ImageAPIClient.manager.loadImage(from: card.image.absoluteString,
                                         completionHandler: {cell.cardImageView.image = $0; cell.setNeedsLayout()},
                                         errorHandler: {print($0)})
//        cardsCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        
        return cell
    }
}

extension CardsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCells: CGFloat = 3
        let numSpaces: CGFloat = numCells + 1
        let screenWidth = UIScreen.main.bounds.width
        
        //return item size
        return CGSize(width: (screenWidth - (10 * numSpaces - 5)) / numCells, height: collectionView.bounds.height - 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}






















