//
//  ArticleCell.swift
//  TableView
//
//  Created by Bogdan on 1/7/20.
//  Copyright © 2020 Bogdan. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleCell: UITableViewCell {
    @IBOutlet weak var titleTxt: UILabel!
    @IBOutlet weak var descriptionTxt: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(article: Article) {
        titleTxt.text = article.title
        descriptionTxt.text = article.description
        if let url = article.urlToImage {
            articleImage.kf.setImage(with: url)
        }
    }
    
}
