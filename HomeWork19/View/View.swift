//
//  View.swift
//  HomeWork19
//
//  Created by Дмитрий Молодецкий on 25.01.2022.
//

import UIKit


class View: UIView {
    weak var delegate: UserActionsDelegate?
    
    let scrollView = UIScrollView()
    let contentView = ContentView()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        
        self.commonInit()
        self.setupSwipe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func switchContent(image: UIImage?, likes: Int, userLike: Bool, comments: [String]?) { // Функция установки нового контента
        self.contentView.image = image
        self.contentView.likes = String(likes)
        self.contentView.comment = "Comments:"
        if comments != nil {
            comments!.forEach { comment in
                self.contentView.comment! += "\nUser: \(comment)"
            }
        }
        if userLike {
            self.contentView.likeButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        else {
            self.contentView.likeButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    private func commonInit() {
        
        // setup ScrollView
        
        self.scrollView.clipsToBounds = true
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.scrollView)
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 35),
            self.scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.keyboardLayoutGuide.topAnchor),
        ])
        
        // setup contentView
                
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(self.contentView)
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
        ])
    }
    
    @objc
    private func swipe(rec: UISwipeGestureRecognizer) {
        switch rec.direction {
        case .right:
            self.delegate?.switchImage(swipeDirection: .right)
        case .left:
            self.delegate?.switchImage(swipeDirection: .left)
        default: return
        }
    }
    
    private func setupSwipe() {
        let left = UISwipeGestureRecognizer(target: self, action: #selector(self.swipe(rec:)))
        let right = UISwipeGestureRecognizer(target: self, action: #selector(self.swipe(rec:)))
        
        left.direction = .left
        right.direction = .right
        
        self.addGestureRecognizer(left)
        self.addGestureRecognizer(right)
    }
}
