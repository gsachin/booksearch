//
//  ViewController.swift
//  mybookshelf
//
//  Created by Sachin Gupta on 1/20/20.
//  Copyright © 2020 Sachin Gupta. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {
    @IBOutlet weak var BookSearchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    var books: [Book] = []
    private var currentPage = 1
    private var showLoadingIndicator = false
    
    
    let searchApi = SearchAPI()
    let bookDetailsApi = BookDetailsAPI()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        BookSearchBar.delegate = self
    }
    @objc
    private func refreshBooks() {
        currentPage = 1
        loadBooks(reload: true)
    }
    
    private func loadBooks(reload: Bool = false) {
        
        guard let search = BookSearchBar.text, search != "" else {
            return
        };        searchApi.getSearchResultResponse(searchTerms:search ,page: currentPage) { (searchResults:SearchResults?) in
            weak var weakself = self
            DispatchQueue.main.async {
                if reload {
                    weakself?.books = searchResults?.books ?? []
                } else {
                    for book in searchResults?.books ?? [] {
                        guard let books = weakself?.books else {
                          continue
                        }
                        if !books.contains(book) {
                           weakself?.books.append(book)
                        }
                        }
                    }
                
            
            //self.shouldShowLoadingCell = page.currentPage < page.numberOfPages
            if let page = Int(searchResults?.page ?? "0"), let total = Int(searchResults?.total ?? "0") {
                weakself?.showLoadingIndicator = page < Int(total/10)
                weakself?.tableView.refreshControl?.endRefreshing()
                weakself?.tableView.reloadData()
            }
            }
            }
        }
    
   
    private func isLoadingRow(_ indexPath: IndexPath) -> Bool {
        guard showLoadingIndicator else { return false }
        return indexPath.row == self.books.count
    }
    private func nextPage() {
        currentPage += 1
        loadBooks()
    }
}

extension BookViewController : UITableViewDataSource, UITableViewDelegate {
    // Mark: TableView Delegate/DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.books.count
        return showLoadingIndicator ? count + 1 : count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isLoadingRow(indexPath) {
            //return LoadingIndicator(style: .default, reuseIdentifier: "refresh")
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellReferesh") as? RefereshCellTableViewCell else {
                return UITableViewCell(style: .default, reuseIdentifier: "CellReferesh")
            }
            cell.activityIndicator.startAnimating()
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BOOKCELLIDENTIFIER) as? BookCell else {
                return UITableViewCell(style: .default, reuseIdentifier: BOOKCELLIDENTIFIER)
            }
            cell.configure(with: books[indexPath.row])
            return cell;
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard isLoadingRow(indexPath) else { return }
        nextPage()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: BOOK_DETAILS_SEGUE_IDENTIFIER, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            let detailVC = segue.destination as! BookDetailsViewController
            detailVC.bookISBN = self.books[selectedRow].isbn13
        }
    }
}

extension BookViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        books.removeAll()
        tableView.reloadData()
        loadBooks()
        resignFirstResponder()
    }
}
