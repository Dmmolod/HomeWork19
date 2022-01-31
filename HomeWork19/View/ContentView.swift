//
//  ContentView.swift
//  HomeWork19
//
//  Created by Дмитрий Молодецкий on 26.01.2022.
//

import UIKit

class ContentView: UIView {
    
    weak var delegate: UserActionsDelegate?
    
    private let imageView = UIImageView()
    private let textField = UITextField()
    private let countOfLikesLable = UILabel()
    private let commentsLable = UILabel()
    let removeDataButton = UIButton()
    let likeButton = UIButton()
    
    var image: UIImage? {
        set {
            self.imageView.image = newValue
        }
        
        get {
            return self.imageView.image
        }
    }
    
    var likes: String? {
        set {
            self.countOfLikesLable.text = newValue
        }
        get {
            self.countOfLikesLable.text
        }
    }
    
    var comment: String? {
        set {
            self.commentsLable.text = newValue
        }
        
        get {
            self.commentsLable.text
        }
    }
    
    init() {
        super.init(frame: .zero)
        self.commonInit()
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.resign)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func resign() { // Скрываю клавиатуру по тапу в любом месте на экране
        self.textField.resignFirstResponder()
    }
    
    private func commonInit() {
        
        // setup imageView
        
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.clipsToBounds = true
        self.imageView.backgroundColor = .white
        
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.imageView)
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor)
        ])
        
        // setup textField
        
        self.textField.delegate = self
        self.textField.returnKeyType = .send
        self.textField.backgroundColor = .white
        self.textField.layer.borderColor = UIColor.systemGray.cgColor
        self.textField.layer.borderWidth = 0.5
        self.textField.layer.cornerRadius = 5
        self.textField.layer.shadowOpacity = 0.2
        
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.textField)
        NSLayoutConstraint.activate([
            self.textField.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 20),
            self.textField.widthAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 1/2),
            self.textField.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        // setup commentsLable
        
        self.commentsLable.layer.shadowOpacity = 0.4
        self.commentsLable.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.commentsLable.backgroundColor = .white
        self.commentsLable.numberOfLines = 0
        
        self.commentsLable.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.commentsLable)
        NSLayoutConstraint.activate([
            self.commentsLable.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.commentsLable.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 20),
            self.commentsLable.widthAnchor.constraint(equalTo: self.imageView.widthAnchor, constant: -20),
            self.commentsLable.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
        ])
        
        // setup button like
        
        self.likeButton.addAction(UIAction(handler: { _ in
            self.delegate?.tapLikeButton() // Передача управления делегату
        }), for: .touchUpInside)
        
        self.likeButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.likeButton)
        NSLayoutConstraint.activate([
            self.likeButton.leftAnchor.constraint(equalTo: self.textField.rightAnchor, constant: 10),
            self.likeButton.topAnchor.constraint(equalTo: self.textField.topAnchor),
            self.likeButton.bottomAnchor.constraint(equalTo: self.textField.bottomAnchor),
            self.likeButton.widthAnchor.constraint(equalTo: self.likeButton.heightAnchor)
        ])
        
        // setup likesLable
        
        self.countOfLikesLable.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.countOfLikesLable)
        NSLayoutConstraint.activate([
            self.countOfLikesLable.leftAnchor.constraint(equalTo: self.likeButton.rightAnchor, constant: 10),
            self.countOfLikesLable.topAnchor.constraint(equalTo: self.textField.topAnchor),
            self.countOfLikesLable.bottomAnchor.constraint(equalTo: self.textField.bottomAnchor)
        ])
        
        // setup remove data Button
        
        self.removeDataButton.backgroundColor = .systemRed
        self.removeDataButton.layer.cornerRadius = 5
        self.removeDataButton.titleLabel?.font = .systemFont(ofSize: 15)
        self.removeDataButton.setTitle("Remove data", for: .normal)
        self.removeDataButton.setTitleColor(.black, for: .normal)
        self.removeDataButton.addAction(UIAction(handler: { _ in
            self.delegate?.removeData()
        }), for: .touchUpInside)
        
        self.addSubview(self.removeDataButton)
        self.removeDataButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.removeDataButton.topAnchor.constraint(equalTo: self.textField.topAnchor),
            self.removeDataButton.rightAnchor.constraint(equalTo: self.textField.leftAnchor, constant: -10),
            self.removeDataButton.bottomAnchor.constraint(equalTo: self.textField.bottomAnchor),
        ])
    }
}

extension ContentView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text,
              !text.isEmpty
        else { return true }
        
        self.delegate?.sendComment(comment: text)
        textField.resignFirstResponder()
        textField.text = nil
        return true
    }
}
