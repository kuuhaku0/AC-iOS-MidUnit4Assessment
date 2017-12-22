//
//  DataModel.swift
//  AC-iOS-MidUnit4Assessment-StudentVersion
//
//  Created by C4Q on 12/22/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit

class DataModel: Codable {
    
    static var selectedPickerRow: Int {
        return UserDefaults.standard.integer(forKey: "SelectedRow")
    }
    
    static let kPathname = "RecentData.plist"
    
    private init(){}
    static let shared = DataModel()
    
    private var lists = [RecentData]() {
        didSet {
            saveFavoritesList()
        }
    }
    
    // returns documents directory path for app sandbox
    private func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // returns the path for supplied name from the dcouments directory
    private func dataFilePath(withPathName path: String) -> URL {
        return DataModel.shared.documentsDirectory().appendingPathComponent(path)
    }
    
    // save
    private func saveFavoritesList() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode([lists])
            try data.write(to: dataFilePath(withPathName: DataModel.kPathname), options: .atomic)
        } catch {
            print("error encoding items: \(error.localizedDescription)")
        }
    }
    
//    func storeImageToDisk(image: UIImage, andCards card: Card) -> Bool {
//        // packing data from image
//        guard let imageData = UIImagePNGRepresentation(image) else { return false }
//
//        // writing and saving to documents folder
//
//        // 1) save image from favorite photo
//        let imageURL = RecentDataStore.manager.dataFilePath(withPathName: card.image)
//        do {
//            try imageData.write(to: imageURL)
//        } catch {
//            print("image saving error: \(error.localizedDescription)")
//        }
//        return true
//    }
    
    // load
    public func load() {
        let path = dataFilePath(withPathName: DataModel.kPathname)
        let decoder = PropertyListDecoder()
        do {
            let data = try Data.init(contentsOf: path)
            lists = try decoder.decode([RecentData].self, from: data)
        } catch {
            print("error decoding items: \(error.localizedDescription)")
        }
    }
    
    // create
    public func addFavoritesItemToList(favoriteItem item: RecentData) {
        lists.append(item)
    }
    
    // read
    public func getLists() -> [RecentData] {
        return lists
    }
    
    // delete
    public func removeFavoritesItemFromIndex(fromIndex index: Int) {
        lists.remove(at: index)
    }
}
