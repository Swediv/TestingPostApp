//
//  MainPostsView.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 21.06.2021.
//

import Foundation
import UIKit

class MainPostsView: UIViewController, MainPostsViewProtocol {
    var configurator: MainConfiguratorProtocol = MainConfigurator()//конфигуратор точно здесь нужен? обычно это обособленная конструкция, нужная только для сборки модуля
    
    var presenter: MainPostsPresenterProtocol!
    
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
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseIdentifier)
        tableView.backgroundView = UIImageView(image: UIImage(named: "sky1"))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    lazy var sortSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: "mostPopular", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "mostCommented", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "createdAt", at: 2, animated: false)
        segmentedControl.setTitleTextAttributes([ .font : UIFont.systemFont(ofSize: 12),
                                                  .foregroundColor : UIColor.white], for: .normal)
        segmentedControl.setTitleTextAttributes([ .font : UIFont.systemFont(ofSize: 13, weight: .bold),
                                                  .foregroundColor : UIColor.white], for: .selected)
        segmentedControl.selectedSegmentTintColor = #colorLiteral(red: 0.1476069689, green: 0.5590839982, blue: 1, alpha: 1)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.backgroundColor = #colorLiteral(red: 0.1137075499, green: 0.2273375094, blue: 0.3450811505, alpha: 1)
        segmentedControl.alpha = 0.7
        return segmentedControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configurator.configure(with: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setConstraints()
    }
    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.767541945, green: 0.7676720023, blue: 0.7675247788, alpha: 1)
        view.addSubview(tableView)
        view.addSubview(sortSegmentedControl)
        view.addSubview(activityIndicator)
        sortSegmentedControl.addTarget(self, action: #selector(sortedBy(_:)), for: .valueChanged)
    }
    private func setConstraints() {
        sortSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        sortSegmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: -3).isActive = true
        sortSegmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 3).isActive = true
        sortSegmentedControl.heightAnchor.constraint(equalToConstant: 35).isActive = true
        tableView.frame = view.bounds
        tableView.topAnchor.constraint(equalTo: sortSegmentedControl.bottomAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func startAnimating() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        
    }
    
    func stopAnimating() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
        
    }
    
    func setTableAtStartPosition() {
        tableView.setContentOffset(.zero, animated: true)
    }
    
    @objc
    private func sortedBy(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            presenter.sorting = .mostPopular
            
        case 1:
            presenter.sorting = .mostCommented
            
        case 2:
            presenter.sorting = .createdAt
            
        default:
            break
        }
    }
}

extension MainPostsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return presenter.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = presenter.posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseIdentifier) as! PostCell
        cell.setupCell(fromPost: post)
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height*0.8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.didTapSelectedRow(atPost: presenter.posts[indexPath.row])
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.isReachedBottom(withTolerance: 60) {
            presenter.loadPosts()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            if scrollView.isReachedBottom(withTolerance: 60) {
                presenter.loadPosts()
            }
        }
    }
}
