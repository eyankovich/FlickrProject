//
//  PhotosGalaryViewCell.swift
//  FlickrProject
//
//  Created by Егор Янкович on 4/1/21.
//

import UIKit

class PhotosGalaryViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
   
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
}
