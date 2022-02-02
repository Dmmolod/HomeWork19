//
//  Model.swift
//  HomeWork19
//
//  Created by Дмитрий Молодецкий on 25.01.2022.
//

import Foundation

    
class Model {
    
    var imageScreens: [ImageScreen]
    
    init() {
        let keys = (0...13).map { number in
            return "image\(number)"  // Создание "ключей" с именем соответствующем названиям изображений, для дальнейшей установки картинок и сохранения по этим "ключам" данных
        }
        self.imageScreens = keys.map { key in // Создание обьектов класса содержащего контент и установка ему либо сохраненных данных, либо данных из памяти
            guard let dataImageScreen = UserDefaults.standard.imageScreen(forKey: key)
            else {
                return ImageScreen(key: key)
            }
            return dataImageScreen
        }
    }
    
    func updateData(content: ImageScreen, forKey: String) {
        UserDefaults.standard.set(content, forKey: forKey)
        //        print(UserDefaults.standard.imageScreen(forKey: self.key) as Any)
    }
}
