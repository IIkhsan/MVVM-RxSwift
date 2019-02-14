//
//  NewsListViewController.swift
//  NewsParser
//
//  Created by Ильяс Ихсанов on 09/02/2019.
//  Copyright © 2019 ilyas. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SafariServices

class NewsListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    
    private let viewModel = NewsListViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
        
        refreshControl.sendActions(for: .valueChanged)
    }
    
    private func setupUI() {
        
        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 100
        tableView.insertSubview(refreshControl, at: 0)
    }
    
    private func setupBindings() {
      
      viewModel.news
        .observeOn(MainScheduler.instance)
        .do(onNext: { [weak self] _ in self?.refreshControl.endRefreshing() })
        .bind(to: tableView.rx.items(cellIdentifier: "NewsCell", cellType: NewsCell.self)) { [weak self] (_, news, cell) in
          self?.setupNewsCell(cell, news: news) }
        .disposed(by: disposeBag)
      
      viewModel.navigationTitle
        .bind(to: navigationItem.rx.title)
        .disposed(by: disposeBag)
      
      viewModel.showNews
        .subscribe(onNext: { [weak self] in self?.openNews($0) })
        .disposed(by: disposeBag)
      
      viewModel.alertMessage
        .subscribe(onNext: { [weak self] in self?.presentAlert(message: $0) })
        .disposed(by: disposeBag)
      
      refreshControl.rx.controlEvent(.valueChanged)
        .bind(to: viewModel.reload)
        .disposed(by: disposeBag)
      
      tableView.rx.modelSelected(NewsViewModel.self)
        .bind(to: viewModel.selectedNews)
        .disposed(by: disposeBag)
    }
    
    private func setupNewsCell(_ cell: NewsCell, news: NewsViewModel) {
        cell.selectionStyle = .none
        cell.setTitle(news.title)
        cell.setDeclaration(news.declaration)
    }
    
    private func presentAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    
    private func openNews(_ url: URL) {
        print(url)
        let safariViewController = SFSafariViewController(url: url)
        navigationController?.pushViewController(safariViewController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationViewController: UIViewController? = segue.destination
        
        if let nvc = destinationViewController as? UINavigationController {
            destinationViewController = nvc.viewControllers.first
        }
    }
}
