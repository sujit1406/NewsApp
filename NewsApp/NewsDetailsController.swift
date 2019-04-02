//
//  NewsDetailsController.swift
//  NewsApp
//
//  Created by Sujith Antony on 30/03/19.
//  Copyright © 2019 Sujith Antony. All rights reserved.
//

import UIKit

class NewsDetailsController: UIViewController {
    @IBOutlet weak var presenter:NewsDetailsPresenter!
    @IBOutlet  var imageView:UIImageView!
    @IBOutlet  var titleLabel:UILabel!
    @IBOutlet  var descriptionLbl:UITextView!
    @IBOutlet  var authorLabel:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = self.view.frame.offsetBy(dx: 0, dy: -20)
        self.view.frame = frame
        if let title = self.presenter.currentFeedItem?.title{
            self.titleLabel.text = title
        }
        if let description = self.presenter.currentFeedItem?.abstract{
            self.descriptionLbl.text = description
        }
        self.presenter.getDetailsImage { (image) in
            self.imageView.image = image
        }
        if let authorLabel = self.presenter.currentFeedItem?.author{
            self.authorLabel.text = authorLabel
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
}
