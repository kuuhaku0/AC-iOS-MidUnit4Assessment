//
//  RecentDataStore.swift
//  AC-iOS-MidUnit4Assessment-StudentVersion
//
//  Created by C4Q on 12/22/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation


import UIKit

class RecentDataStore {

    static let kPathname = "Favorites.plist"

    // singleton
    private init(){}
    static let manager = RecentDataStore()

    private var recents = [RecentData]() {
        didSet{
            saveToDisk()
        }
    }

    // returns documents directory path for app sandbox
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // /documents/Favorites.plist
    // returns the path for supplied name from the dcouments directory
    func dataFilePath(withPathName path: String) -> URL {
        return RecentDataStore.manager.documentsDirectory().appendingPathComponent(path)
    }

    // save to documents directory
    // write to path: /Documents/
    func saveToDisk() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(recents)
            // Does the writing to disk
            try data.write(to: dataFilePath(withPathName: RecentDataStore.kPathname), options: .atomic)
        } catch {
            print("encoding error: \(error.localizedDescription)")
        }
        print("\n==================================================")
        print(documentsDirectory())
        print("===================================================\n")
    }

    // load from documents directory
    func load() {
        // what's the path we are reading from?
        let path = dataFilePath(withPathName: RecentDataStore.kPathname)
        let decoder = PropertyListDecoder()
        do {
            let data = try Data.init(contentsOf: path)
            recents = try decoder.decode([RecentData].self, from: data)
        } catch {
            print("decoding error: \(error.localizedDescription)")
        }
    }
//
//    // does 2 tasks:
//    // 1. stores image in documents folder
//    // 2. appends favorite item to array
//    func addToRecents(game: Card, andImage image: UIImage) -> Bool  {
//        // checking for uniqueness
//        let indexExist = recents.index{ $0.value == game.value }
//        if indexExist != nil { print("FAVORITE EXIST"); return false }
//
//        // 1) save image from favorite photo
//        let success = storeImageToDisk(image: image, andGame: game)
//        if !success { return false }
//
//        // 2) save favorite object
//        let newRecents = RecentData.init(value: game.value)
//        recents.append(newRecents)
//        return true
//    }
//
//    // store image
//    func storeImageToDisk(image: UIImage, andGame cards: Card) -> Bool {
//        // packing data from image
//        guard let imageData = UIImagePNGRepresentation(image) else { return false }
//
//        // writing and saving to documents folder
//
//        // 1) save image from favorite photo
//        let imageURL = RecentDataStore.manager.dataFilePath(withPathName: cards.image.absoluteString)
//        do {
//            try imageData.write(to: imageURL)
//        } catch {
//            print("image saving error: \(error.localizedDescription)")
//        }
//        return true
//    }
//
//    func isMovieInFavorites(card: Card) -> Bool {
//        // checking for uniqueness
//        let indexExist = recents.index{ $0.value == card.value }
//        if indexExist != nil {
//            return true
//        } else {
//            return false
//        }
//    }
//
//    func getFavoriteWithId(value: String) -> RecentData? {
//        let index = getFavorites().index{$0.value == value}
//        guard let indexFound = index else { return nil }
//        return recents[indexFound]
//    }
//
//    func getFavorites() -> [RecentData] {
//        return recents
//    }
//
//    func removeFavorite(fromIndex index: Int, andMovieImage recent: RecentData) -> Bool {
//        recents.remove(at: index)
//        // remove image
//        let imageURL = RecentDataStore.manager.dataFilePath(withPathName: recent.image)
//        do {
//            try FileManager.default.removeItem(at: imageURL)
//            print("\n==============================================================================")
//            print("\(imageURL) removed")
//            print("==============================================================================\n")
//            return true
//        } catch {
//            print("error removing: \(error.localizedDescription)")
//            return false
//        }
//    }
//
}

