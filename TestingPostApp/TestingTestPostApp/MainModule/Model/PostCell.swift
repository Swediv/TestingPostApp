//
//  PostCell.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 21.06.2021.
//

import Foundation
import UIKit

class PostCell: UITableViewCell {
    
    var imageURL: URL? {
        didSet {
            contentImageView.image = nil
            setImage()
        }
    }
    lazy var activityIndicator: UIActivityIndicatorView = {
        let refreshControl = UIActivityIndicatorView()
        refreshControl.color = .white
        refreshControl.hidesWhenStopped = true
        refreshControl.translatesAutoresizingMaskIntoConstraints = false
        
        return refreshControl
    }()
    lazy var commentsCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame.size = CGSize(width: 50, height: 26)
        
        return label
    }()
    lazy var commentsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame.size = CGSize(width: 30, height: 30)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 13
        imageView.backgroundColor = .darkGray
        
        return imageView
    }()
    lazy var shareCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame.size = CGSize(width: 50, height: 26)
        
        return label
    }()
    lazy var shareImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame.size = CGSize(width: 30, height: 30)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 13
        imageView.backgroundColor = .black
        
        return imageView
    }()
    lazy var likeCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame.size = CGSize(width: 50, height: 26)
        
        return label
    }()
    lazy var likeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame.size = CGSize(width: 30, height: 30)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 13
        imageView.backgroundColor = #colorLiteral(red: 0.5837096572, green: 0.2491314113, blue: 1, alpha: 1)
        
        return imageView
    }()
    
    lazy var footerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.systemGray
        view.alpha = 0.8
        return view
    }()
    lazy var contentImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    lazy var descriptionLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.1137075499, green: 0.2273375094, blue: 0.3450811505, alpha: 1)
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.contentView.addSubview(mainView)
        mainView.addSubview(descriptionLbl)
        mainView.addSubview(contentImageView)
        mainView.addSubview(footerView)
        footerView.addSubview(likeImageView)
        footerView.addSubview(likeCountLabel)
        footerView.addSubview(commentsImageView)
        footerView.addSubview(commentsCountLabel)
        footerView.addSubview(shareImageView)
        footerView.addSubview(shareCountLabel)
        mainView.addSubview(activityIndicator)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.descriptionLbl.text = ""
        self.contentImageView.image = nil
        self.likeCountLabel.text = ""
        self.commentsCountLabel.text = ""
        self.shareCountLabel.text = ""
    }
    private func setupUI() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            descriptionLbl.topAnchor.constraint(equalTo: mainView.topAnchor),
            descriptionLbl.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 5),
            descriptionLbl.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -5),
            descriptionLbl.heightAnchor.constraint(equalToConstant: 60),
            contentImageView.topAnchor.constraint(equalTo: descriptionLbl.bottomAnchor),
            contentImageView.widthAnchor.constraint(equalTo: mainView.widthAnchor),
            contentImageView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            footerView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            footerView.widthAnchor.constraint(equalTo: mainView.widthAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 30),
            likeImageView.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 10),
            likeImageView.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            likeCountLabel.leadingAnchor.constraint(equalTo: likeImageView.trailingAnchor, constant: 3),
            likeCountLabel.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            commentsImageView.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            commentsImageView.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            commentsCountLabel.leadingAnchor.constraint(equalTo: commentsImageView.trailingAnchor),
            commentsCountLabel.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            shareCountLabel.trailingAnchor.constraint(equalTo: footerView.trailingAnchor,constant: -10),
            shareCountLabel.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            shareImageView.trailingAnchor.constraint(equalTo: shareCountLabel.leadingAnchor, constant: -3),
            shareImageView.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: mainView.centerYAnchor)
        ])
    }
    func setupCell(fromPost item: Item) {
        self.likeImageView.image = UIImage(named: "like")
        self.likeCountLabel.text = String(item.stats.likes.count)
        self.commentsImageView.image = UIImage(named: "msg")
        self.commentsCountLabel.text = String(item.stats.comments.count)
        self.shareImageView.image = UIImage(named: "share")
        self.shareCountLabel.text = String(item.stats.shares.count)
        
        item.contents.forEach { content in
            
            switch content.type {
            case "TEXT":
                self.descriptionLbl.text = content.data.value
            case "IMAGE":
                if let url = content.data.original?.url {
                    self.imageURL = URL(string: url)
                }
            case "IMAGE_GIF":
                if let url = content.data.original?.url {
                    self.imageURL = URL(string: url)
                }
            case "VIDEO":
                if let url = content.data.previewImage?.data.medium.url {
                    self.imageURL = URL(string: url)
                }
            default:
                break
            }
        }
    }
    private func setImage() {
        activityIndicator.startAnimating()
        if let url = imageURL {
            ImageService.getImage(withUrl: url) { image in
                self.contentImageView.image = image
            }
        }
        activityIndicator.stopAnimating()
    }
}
