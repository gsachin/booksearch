//
//  BookCell.swift
//  mybookshelf
//
//  Created by Sachin Gupta on 1/26/20.
//  Copyright © 2020 Sachin Gupta. All rights reserved.
//

import UIKit
import Alamofire
class BookCell: UITableViewCell {

    // Mark: Outlets
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var isbn: UIButton!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // Mark: Properties
    var book : Book?
    var photosManager: ImageManager { return .shared }
    var request: Request?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with book: Book) {
        self.book = book
        reset()
        loadImage()
        loadData()
    }
    func loadData() {
        title.text = book?.title
        subTitle.text = book?.subtitle
        price.text = book?.price
        isbn.setTitle(book?.isbn13, for: .normal)
    }
    func reset() {
        bookImage.image = nil
        request?.cancel()
    }
    
    func loadImage() {
        if let img = book?.image {
        if let image = photosManager.cachedImage(for: img) {
            populate(with: image)
            return
        }
        downloadImage()
        }
    }
    
    func downloadImage() {
        activityIndicatorView.startAnimating()
        if let img = book?.image {
        request = photosManager.fetchImage(for: img) { image in
            DispatchQueue.main.async {
                 self.populate(with: image)
            }
        }
        }
    }
    
    func populate(with image: UIImage) {
        activityIndicatorView.stopAnimating()
        imageView?.image = image
    }
}
