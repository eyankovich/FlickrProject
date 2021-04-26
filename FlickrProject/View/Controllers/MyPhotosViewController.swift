//
//  MyPhotosViewController.swift
//  FlickrProject
//
//  Created by Егор Янкович on 4/1/21.
//

import UIKit

class MyPhotosViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var photos: [Galary] = []
    let countCells = 9
    let oauthParameter = OAuth()
    lazy var auth = oauthParameter.oauthswift

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "PhotosGalaryViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotosGalaryViewCell")
        oauthParameter.getMyGalery(auth, consumerKey: "7fc94f2cca0dc9714e6b410e90256ce9")
    }
    
    
    
}

extension MyPhotosViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let image = photos[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosGalaryViewCell", for: indexPath) as! PhotosGalaryViewCell
        cell.imageView.image = UIImage(data: try! Data(contentsOf: image.photo!))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameCV = collectionView.frame
        let widthCell = frameCV.width/CGFloat(countCells)
        let hightCell = widthCell
        return CGSize(width: widthCell, height: hightCell)
    }
}
