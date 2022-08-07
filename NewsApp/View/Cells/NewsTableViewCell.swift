//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Gabriel de Castro Chaves on 04/08/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    
    //MARK: IBOutlets
    @IBOutlet weak private var newsImage: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var pubDateLabel: UILabel!
    
    //MARK: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //MARK: Funcs
    }
    func setupCell(image: String, title: String, description: String, pubDate: String) {
        newsImage.loadFrom(URLAddress: image)
        titleLabel.text = title
        descriptionLabel.text = description
        pubDateLabel.text = pubDate
    }
}







