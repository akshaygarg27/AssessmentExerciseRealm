//
//  HomeViewController.swift
//  Assessment
//
//  Created by Omika Garg on 10/10/19.
//  Copyright © 2019 Akshay Garg. All rights reserved.
//

import UIKit
import RealmSwift

/// Home view controller contains the UI Action & responses
class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    /// Configure Home View
    private func configureView() {
        (view as? HomeView)?.delegate = self
        let exercise: [ArticleViewModel] = RealmManager.shared.getArticles()
        if exercise.isEmpty {
            (view as? HomeView)?.activityIndicator.startAnimating()
            fetchExerciseData()
        }
        else {
            self.fetchFromDB()
        }
    }
    
    /// Set data help to fetch data from file.
    private func fetchExerciseData() {
        Presenter.fetchExerciseData { (exercise, success) in
            (self.view as? HomeView)?.activityIndicator.stopAnimating()
            if !success { return }
            self.title = exercise?.first?.displayHeaderTitle
            (self.view as? HomeView)?.setData(exercise)
        }
    }
    
    /// Fetch data from DB.
    private func fetchFromDB() {
        let exercise: [ArticleViewModel] = RealmManager.shared.getArticles()
        self.title = exercise.first?.displayHeaderTitle
        (self.view as? HomeView)?.setData(exercise)
    }
}

// MARK: - HomeViewOutputProtocol
extension HomeViewController: HomeViewOutputProtocol {
    func selectedCell(at: Int, article: ArticleViewModel) {
        guard let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return
        }

        (detailViewController.view as? DetailView)?.setData(article)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
