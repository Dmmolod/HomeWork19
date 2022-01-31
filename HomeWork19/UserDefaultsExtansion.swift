//
//  UserDefaults.swift
//  HomeWork19
//
//  Created by Дмитрий Молодецкий on 31.01.2022.
//

import Foundation

extension UserDefaults {
    
    func imageScreen(forKey imageScreenKey: String) -> ImageScreen? {
        if let imageScreenJSONData = self.data(forKey: imageScreenKey) {
            return try? JSONDecoder().decode(ImageScreen.self, from: imageScreenJSONData)
        }
        return nil
    }
    
    func set(_ imageScreen: ImageScreen?, forKey key: String) {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        
        let imageScreenJSONData = try? jsonEncoder.encode(imageScreen)
        self.setValue(imageScreenJSONData, forKey: key)
    }
}
