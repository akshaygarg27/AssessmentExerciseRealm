//
//  Presenter.swift
//  Assessment
//
//  Created by Omika Garg on 10/10/19.
//  Copyright © 2019 Akshay Garg. All rights reserved.
//

import Foundation
import RealmSwift

final public class Presenter {
    
    class func fetchExerciseData(handler: @escaping ((_ exercise: [ArticleViewModel]?, _ success: Bool) -> Void)) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        guard appDelegate.isNetworkAvailable else {
            
            let alert = UIAlertController(title: "Network Unavailable", message: "Please connect to the internet in order to proceed.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            appDelegate.window?.rootViewController?.present(alert, animated: true, completion: nil)
            return
        }
        
        guard let url = URL(string: "https://no89n3nc7b.execute-api.ap-southeast-1.amazonaws.com/staging/exercise") else { return }
        let request = NSMutableURLRequest(url: url)
        
        WebServiceClass.sharedInstance.getMethod(request: request) { (success, data) in
            if success, let exerciseJson = data as? Dictionary<String, AnyObject> {
                DispatchQueue.main.sync {
                    let headerTitle = exerciseJson["title"] as? String
                    guard let jsonArticles = exerciseJson["articles"] as? [Dictionary<String, AnyObject>] else {
                        return
                    }
                    
                    for article in jsonArticles {
                        if let title = article["title"] as? String, title.isEmpty {
                            continue
                        }
                        
                        let article = RealmArticle(headerTitle, articleDict: article)
                        RealmManager.shared.add(object: article)
                    }
                    
                    let articles: [ArticleViewModel] = RealmManager.shared.getArticles()
                    handler(articles, true)
                }
            } else {
                /// Need to handle error.
                handler(nil, false)
            }
        }
    }
}

