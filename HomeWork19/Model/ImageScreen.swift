//
//  ImageScreen.swift
//  HomeWork19
//
//  Created by Дмитрий Молодецкий on 25.01.2022.
//

import Foundation
import UIKit

class ImageScreen: Codable {

    var key: String
    var imageName: String
    var userLike: Bool = false  {
        didSet {
            self.updateData()
        }
    }
    var likes: Int = 0  {
        didSet {
            self.updateData()
        }
    }
    
    var comments: [String]? {
        didSet {
            self.updateData()
        }
    }
    
    init(key: String) {
        self.likes = (0...15000).shuffled().first! // Сделал просто для интереса, после оставления комментария или лайка, число больше не меняеется а тянется из памяти
        self.key = key
        self.imageName = key
    }
    
    func getImage() -> UIImage? {
        if let image = UIImage(named: self.imageName) {
            return image
        }
        else { return UIImage(systemName: "person.2.crop.square.stack") }
    }
    
    private func updateData() {
        UserDefaults.standard.set(self, forKey: self.key)
//        print(UserDefaults.standard.imageScreen(forKey: self.key) as Any)
    }
}
