//
//  UserActionsController.swift
//  HomeWork19
//
//  Created by Дмитрий Молодецкий on 28.01.2022.
//

import UIKit

protocol UserActionsDelegate: AnyObject {
    func switchImage(swipeDirection: UISwipeGestureRecognizer.Direction)
        
    func tapLikeButton()
    
    func sendComment(comment: String)
    
    func removeData()
}

class UserActionsController {
        
    let tapLikeHandler: TapHandler
    let switchImageHandler: SwipeDirectionHandler
    let sendCommentHandler: StringHandler
    let removeDataHandler: TapHandler
    
    init(tapHandler: @escaping TapHandler,
         switchImageHandler: @escaping SwipeDirectionHandler,
         sendCommentHandler: @escaping StringHandler,
         removeDataHandler: @escaping TapHandler) {
        
        self.tapLikeHandler = tapHandler
        self.switchImageHandler = switchImageHandler
        self.sendCommentHandler = sendCommentHandler
        self.removeDataHandler = removeDataHandler
    }
}

extension UserActionsController: UserActionsDelegate {
    
    func switchImage(swipeDirection: UISwipeGestureRecognizer.Direction) {
        self.switchImageHandler(swipeDirection)
    }
    
    func tapLikeButton() {
        self.tapLikeHandler()
    }
    
    func sendComment(comment: String) {
        self.sendCommentHandler(comment)
    }
    
    func removeData() {
        self.removeDataHandler()
    }
}

