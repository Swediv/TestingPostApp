//
//  DetailsViewController.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 22.06.2021.
//

import UIKit

class DetailsViewController: UIViewController, DetailsViewControllerProtocol {
    var presenter: DetailsPresenterProtocol!
    
//    var configurator: DetailsConfiguratorProtocol = DetailsConfigurator()
    
    lazy var loadLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var activityIndicator: UIActivityIndicatorView = {
        let refreshControl = UIActivityIndicatorView()
        refreshControl.color = .white
        refreshControl.addSubview(loadLabel)
        loadLabel.topAnchor.constraint(equalTo: refreshControl.bottomAnchor).isActive = true
        loadLabel.centerXAnchor.constraint(equalTo: refreshControl.centerXAnchor).isActive = true
        refreshControl.style = .large
        refreshControl.hidesWhenStopped = true
        refreshControl.translatesAutoresizingMaskIntoConstraints = false
        
        
        return refreshControl
    }()
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var authorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 18
    
        return imageView
    }()
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.1137075499, green: 0.2273375094, blue: 0.3450811505, alpha: 1)
        return view
    }()
    lazy var navView: UIView = {
        let navView = UIView()
        navView.translatesAutoresizingMaskIntoConstraints = false
        navView.frame.size = CGSize(width: authorImageView.frame.size.width + authorLabel.frame.size.width + 30, height: 40)
        return navView
    }()
    lazy var contentTextLabel: UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.numberOfLines = 0
        textView.sizeToFit()
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.textColor = .white
        return textView
    }()
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        scrollView.frame = view.bounds
        return scrollView
    }()
    lazy var contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.updateView()  
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = #colorLiteral(red: 0.1137075499, green: 0.2273375094, blue: 0.3450811505, alpha: 1)
        view.addSubview(scrollView)
        view.addSubview(activityIndicator)
        scrollView.addSubview(mainView)
        mainView.addSubview(contentImageView)
        mainView.addSubview(contentTextLabel)
        navView.addSubview(authorLabel)
        navView.addSubview(authorImageView)
        
        navigationItem.titleView = navView
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        contentImageView.image = nil
        contentTextLabel.text = nil
        authorLabel.text = nil
        authorImageView.image = nil
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setConstraints()
    }
    func setConstraints() {
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        mainView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        contentImageView.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        contentImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        contentImageView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        contentImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 600).isActive = true
        contentTextLabel.topAnchor.constraint(equalTo: contentImageView.bottomAnchor, constant: 10).isActive = true
        contentTextLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8).isActive = true
        contentTextLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8).isActive = true
        contentTextLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
        
        authorImageView.topAnchor.constraint(equalTo: navView.topAnchor).isActive = true
        authorImageView.leadingAnchor.constraint(equalTo: navView.leadingAnchor, constant: 8).isActive = true
        authorImageView.widthAnchor.constraint(equalToConstant: 36).isActive = true
        authorImageView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        authorImageView.centerYAnchor.constraint(equalTo: navView.centerYAnchor).isActive = true
        authorLabel.topAnchor.constraint(equalTo: navView.topAnchor).isActive = true
        authorLabel.leadingAnchor.constraint(equalTo: authorImageView.trailingAnchor, constant: 5).isActive = true
        authorLabel.centerYAnchor.constraint(equalTo: navView.centerYAnchor).isActive = true
        navView.leadingAnchor.constraint(equalTo: navigationItem.titleView!.leadingAnchor, constant: 5).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    func showAuthorName(with name: String) {
        DispatchQueue.main.async {
            self.authorLabel.text = name
        }
    }
    func showAuthorImage(with image: UIImage?) {
        DispatchQueue.main.async {
            self.authorImageView.image = image
        }
    }
    func showContentImage(with image: UIImage?) {
        DispatchQueue.main.async {
            self.contentImageView.image = image
        }
    }    
    func showDescriptionText(with text: [String]) {
        DispatchQueue.main.async {
            self.contentTextLabel.text = text.joined(separator: "."+"\n")
        }
    }   
}
extension DetailsViewController: UIScrollViewDelegate {
    
}
    

