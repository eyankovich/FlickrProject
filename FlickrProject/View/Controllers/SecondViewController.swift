//
//  SecondViewController.swift
//  FlickrProject
// UIImage(data: try! Data(contentsOf: image.imageURL!))
//  Created by Егор Янкович on 3/2/21.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var collectionArray: [PhotoCellModel] = []
    var indexPath: IndexPath!
    let countCells = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "PhotoCollectionCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCollectionCell")
        self.collectionView.performBatchUpdates(nil){ (result) in
            self.collectionView.scrollToItem(at: self.indexPath, at: .centeredHorizontally, animated: false)
        }
    }
}

extension SecondViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let image = collectionArray[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionCell", for: indexPath) as! PhotoCollectionCell
        cell.titleCollection.text = image.title
        cell.photoCollectionImage.image = UIImage(data: try! Data(contentsOf: image.imageURL!))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameCV = collectionView.frame
        let widthCell = frameCV.width/CGFloat(countCells)
        let hightCell = widthCell
        return CGSize(width: widthCell, height: hightCell)
    }
}
