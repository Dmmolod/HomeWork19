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
    var userLike: Bool = false
    var likes: Int = 0
    var comments: [String]?
    
    init(key: String) {
        self.likes = (0...15000).shuffled().first! // Сделал просто для интереса) После оставления комментария или лайка число больше не меняеется а тянется из памяти
        self.key = key
        self.imageName = key
    }
    
    func getImage() -> UIImage? {
        if let image = UIImage(named: self.imageName) {
            return image
        }
        else { return UIImage(systemName: "person.2.crop.square.stack") }
    }
    

}
