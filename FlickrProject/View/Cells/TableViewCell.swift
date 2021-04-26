//
//  TableViewCell.swift
//  FlickrProject
//
//  Created by Егор Янкович on 3/10/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewXib: UIImageView!
    @IBOutlet weak var textLabelXib: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageViewXib.image = nil
        self.textLabelXib.text = nil
        imageViewXib.clipsToBounds = true
    }
}
