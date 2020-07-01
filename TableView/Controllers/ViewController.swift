//
//  ViewController.swift
//  TableView
//
//  Created by Bogdan on 1/7/20.
//  Copyright © 2020 Bogdan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Variables
    private var articles = [Article]()
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Latest News"
        getLatestNews()
        configureTableView()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.CellIdentifiers.ARTICLE_CELL, bundle: nil), forCellReuseIdentifier: Constants.CellIdentifiers.ARTICLE_CELL)
    }
    
    func getLatestNews() {
        activityIndicator.startAnimating()
        NewsNetworkManager.shared.getAppleArticles { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let articles):
                self.articles = articles
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.tableView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
                print(error)
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.ARTICLE_CELL, for: indexPath) as? ArticleCell {
            cell.configure(article: articles[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}

