//
//  HomeView.swift
//  Assessment
//
//  Created by Omika Garg on 10/10/19.
//  Copyright © 2019 Akshay Garg. All rights reserved.
//

import UIKit

/// Home view output protocols.
protocol HomeViewOutputProtocol: class {
    /// Selected cell details.
    ///
    /// - Parameters:
    ///   - at: Selected cell index, Type will be **Int**
    ///   - article: ArticleViewModel
    func selectedCell(at: Int, article: ArticleViewModel)
}

/// Home view contains the home view elements.
class HomeView: UIView {
    
    @IBOutlet private weak var tableViewHome: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
   
    private var articlesList: [ArticleViewModel]?
   
    weak var delegate: HomeViewOutputProtocol?
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(HomeView.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        return refreshControl
    }()
    
    /// Set Data To TableView Cell
    ///
    /// - Parameter exercise: ExerciseViewModel
    func setData(_ exercise: [ArticleViewModel]?) {
        articlesList = exercise
        self.tableViewHome.isHidden = false
        self.tableViewHome.addSubview(self.refreshControl)
        tableViewHome.tableFooterView = UIView()
        tableViewHome.delegate = self
        tableViewHome.dataSource = self
        tableViewHome.reloadData()
    }
    
    /// Pull down to refresh handle
    ///
    /// - Parameter refreshControl: Object should be type of **UIRefreshControl**.
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
    }
}

// MARK: - UITableView Delegates and DataSource Methods.
extension HomeView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = articlesList?.count else {
            return 0
        }
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell") as? ArticleTableViewCell else {
            return UITableViewCell()
        }
        
        if let article = articlesList?[indexPath.row] {
            cell.setArticleData(article)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let article = articlesList?[indexPath.row] else {
            return
        }
        delegate?.selectedCell(at: indexPath.row, article: article)
    }
}
