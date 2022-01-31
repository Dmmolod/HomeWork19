//
//  ViewController.swift
//  HomeWork19
//
//  Created by Дмитрий Молодецкий on 25.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var myView = View()
    private let model = Model()
    private lazy var userActionsController = UserActionsController(tapHandler: self.tapLikeButton,                          // Создаю ответственного за делегирование
                                                                   switchImageHandler: self.switchImage(swipeDirection:),
                                                                   sendCommentHandler: self.sendComment(comment:),
                                                                   removeDataHandler: self.removeData)
    
    override func loadView() {
        self.view = self.myView
        self.setDelegate() // Устанавливаю делегаты
        self.setContent(content: self.model.currentContent) // Устанавливаю первоначальный контент
        //        print(NSSearchPathForDirectoriesInDomains(.documentDirectory,
        //                                                  .userDomainMask,
        //                                                  true).first!)
    }
    
    private func setContent(content: ImageScreen) { // Функция установки контента
        self.myView.switchContent(image: content.getImage(),
                                  likes: content.likes,
                                  userLike: content.userLike,
                                  comments: content.comments)
    }
    
    private func setDelegate() { // Установка делегатов
        self.myView.delegate = self.userActionsController
        self.myView.contentView.delegate = self.userActionsController
    }
    
    func switchImage(swipeDirection: UISwipeGestureRecognizer.Direction) { // функция смены контента исходя из стороны свайпа
        
        switch swipeDirection {
        case .right:
            self.model.previousContent()
        case .left:
            self.model.nextContent()
        default: return
        }
        self.setContent(content: self.model.currentContent)
    }
    
    func tapLikeButton() {
        self.model.setLike()
        self.setContent(content: self.model.currentContent)
    }
    
    func sendComment(comment: String) {
        self.model.setComment(comment: comment)
        self.setContent(content: self.model.currentContent)
    }
    
    func removeData() {
        self.model.removeCurrentData()
    }
}
