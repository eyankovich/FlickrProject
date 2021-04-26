//
//  PhotoCollectionCell.swift
//  FlickrProject
//
//  Created by Егор Янкович on 3/2/21.
//

import UIKit

class PhotoCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var photoCollectionImage: UIImageView!
    @IBOutlet weak var titleCollection: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoCollectionImage.image = nil
        self.titleCollection.text = nil
    }
}
