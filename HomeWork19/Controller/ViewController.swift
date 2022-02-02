//
//  ViewController.swift
//  HomeWork19
//
//  Created by Дмитрий Молодецкий on 25.01.2022.
//

import UIKit

protocol UserActionsDelegate: AnyObject {
    func switchImage(swipeSide: SwipeSide)
        
    func tapLikeButton()
    
    func sendComment(comment: String)
    
    func removeData()
}

class ViewController: UIViewController {
    
    private lazy var myView = View()
    private let model = Model()
    private var swipeSide: SwipeSide? = .left
    private var currentContent: ImageScreen {
        didSet {
            self.model.updateData(content: self.currentContent, forKey: self.currentKey)
            self.setContent(content: self.currentContent)
        }
    }
    private var currentKey: String {
        get {
            return self.currentContent.key
        }
    }
    private var currentContentIndex: Int? {
        return self.model.imageScreens.firstIndex { imageScreen in
            self.currentContent === imageScreen
        }
    }
    
    init() {
        self.currentContent = self.model.imageScreens[0] // Установка текущего контента как первого элемента из массива со всем контентом
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.myView
        self.setDelegate()// Устанавливаю делегаты
        self.setContent(content: self.currentContent) // Устанавливаю первоначальный контент
        //        print(NSSearchPathForDirectoriesInDomains(.documentDirectory,
        //                                                  .userDomainMask,
        //                                                  true).first!)
    }
    
    private func setContent(content: ImageScreen) { // Функция установки контента
        self.myView.switchContent(image: content.getImage(),
                                  likes: content.likes,
                                  userLike: content.userLike,
                                  comments: content.comments,
                                  swipeSide: self.swipeSide)
    }
    
    func nextContent() { // выбор следующего контента
        guard let currentIndex = self.currentContentIndex,
              let firstImageScreen = self.model.imageScreens.first  else { return }
        
        if self.currentContentIndex == self.model.imageScreens.count - 1 {
            self.currentContent = firstImageScreen
        }
        else {
            self.currentContent = self.model.imageScreens[currentIndex+1]
        }
    }
    
    func previousContent() {
        guard let currentIndex = self.currentContentIndex,
              let lastImageScreen = self.model.imageScreens.last else { return }
        
        if self.currentContentIndex == 0 {
            self.currentContent = lastImageScreen
        }
        else {
            self.currentContent = self.model.imageScreens[currentIndex-1]
        }
    }
    
    private func setDelegate() { // Установка делегатов
        self.myView.delegate = self
    }
}

extension ViewController: UserActionsDelegate {
    
    func switchImage(swipeSide: SwipeSide) {
        switch swipeSide {
        case .right:
            self.swipeSide = .right
            self.previousContent()
        case .left:
            self.swipeSide = .left
            self.nextContent()
        }
        self.swipeSide = nil // Т.к. у меня анимация зависит от стороны свайпа, а при лайке или комменте у меня по новой отрисовывается экран, то приходится сбрасывать значение свайпа, чтобы при лайке или комменте не было анимации листания
    }
    
    func tapLikeButton() {
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
        self.setContent(content: self.currentContent)
        self.model.updateData(content: self.currentContent, forKey: self.currentKey)
    }
    
    func sendComment(comment: String) {
        if self.currentContent.comments == nil {
            self.currentContent.comments = [comment]
        }
        else{
            self.currentContent.comments?.append(comment)
        }
        self.setContent(content: self.currentContent)
        self.model.updateData(content: self.currentContent, forKey: self.currentKey)
    }
    
    func removeData() {
        let key = self.currentKey
        UserDefaults.standard.removeObject(forKey: key)
        print("Data for key: \(key) - is removed")
    }
}


