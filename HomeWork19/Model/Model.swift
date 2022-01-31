//
//  Model.swift
//  HomeWork19
//
//  Created by Дмитрий Молодецкий on 25.01.2022.
//

import Foundation
    
class Model {

    var ImageScreens: [ImageScreen]
    var currentContent: ImageScreen
    var currentContentIndex: Int? {
        return self.ImageScreens.firstIndex { imageScreen in
            self.currentContent === imageScreen
        }
    }

    
    init() {
        let keys = (0...13).map { number in
            return "image\(number)"  // Создание "ключей" с именем соответствующем названиям изображений, для дальнейшей установки картинок и сохранения по этим "ключам" данных
        }
        self.ImageScreens = keys.map { key in // Создание обьектов класса содержащего контент и установка ему либо сохраненных данных, либо данных из памяти
            guard let dataImageScreen = UserDefaults.standard.imageScreen(forKey: key)
            else {
                return ImageScreen(key: key)
            }
            return dataImageScreen
        }
        self.currentContent = self.ImageScreens[0] // Установка текущего контента как первого элемента из массива со всем контентом
    }
    
    func nextContent() { // выбор следующего контента
        guard let currentIndex = self.currentContentIndex,
              let firstImageScreen = self.ImageScreens.first  else { return }

        if self.currentContentIndex == self.ImageScreens.count - 1 {
            self.currentContent = firstImageScreen
        }
        else {
            self.currentContent = self.ImageScreens[currentIndex+1]
        }
    }
    
    func previousContent() {
        guard let currentIndex = self.currentContentIndex,
              let lastImageScreen = self.ImageScreens.last else { return }

        if self.currentContentIndex == 0 {
            self.currentContent = lastImageScreen
        }
        else {
            self.currentContent = self.ImageScreens[currentIndex-1]
        }
    }
    
    func setComment(comment: String) {
        if self.currentContent.comments == nil {
            self.currentContent.comments = [comment]
        }
        else{
            self.currentContent.comments?.append(comment)
        }
    }
    
    func setLike() {
        if self.currentContent.userLike {
            self.currentContent.userLike = false
            if self.currentContent.likes > 0 {
                self.currentContent.likes -= 1
            }
        }
        else {
            self.currentContent.userLike = true
            self.currentContent.likes += 1
        }
    }
    
    func removeCurrentData() {
        let key = self.currentContent.key
        UserDefaults.standard.removeObject(forKey: key)
        print("Data for key: \(key) - is removed")
    }
}
