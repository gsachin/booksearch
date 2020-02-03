//
//  BookDetailsViewController.swift
//  mybookshelf
//
//  Created by Sachin Gupta on 2/3/20.
//  Copyright © 2020 Sachin Gupta. All rights reserved.
//

import UIKit
import Alamofire
class BookDetailsViewController: UIViewController {

    let bookDetailsApi = BookDetailsAPI()
    var bookDetails: BookDetails?
     var photosManager: ImageManager { return .shared }
    var bookISBN : String?
    @IBOutlet weak var publisherName: UILabel!
    @IBOutlet weak var Year: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var descriptions: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var pages: UILabel!
    var request: Request?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let isbn = bookISBN {
             weak var weakself = self
            bookDetailsApi.getBookDetailsResponse(ISBN: isbn) { (bookDetails:BookDetails?) in
                DispatchQueue.main.async {
                    if let details = bookDetails {
                        weakself?.bookDetails = details
                        weakself?.ReLoadView(details)
                    } else {
                        let alert = UIAlertController(title: "Error", message: "Unknown error found.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Please try again.."), style: .default, handler: { _ in
                            self.navigationController?.popViewController(animated: true)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func ReLoadView(_ bookDetails:BookDetails) {
        bookTitle.text = bookDetails.title
        subTitle.text = bookDetails.subtitle
        publisherName.text = bookDetails.publisher
        Year.text = bookDetails.year
        pages.text = bookDetails.pages
        price.text = bookDetails.price
        descriptions.text = bookDetails.desc
        showImage(imageUrl: bookDetails.image)
    }
    func showImage(imageUrl:String?) {
        if let img = imageUrl {
            weak var weakself = self
            request = photosManager.fetchImage(for: img) { image in
                DispatchQueue.main.async {
                    weakself?.bookImage?.image = image
                }
            }
        }
    }
    @IBAction func ViewMoreDetails(_ sender: Any) {
        if let url = bookDetails?.url, let requestUrl = URL(string: url) {
            UIApplication.shared.open(requestUrl)
        }
    }
}
