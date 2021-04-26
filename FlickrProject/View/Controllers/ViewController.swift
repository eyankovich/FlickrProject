//
//  ViewController.swift
//  FlickrProject
//
//
//
//  Created by Егор Янкович on 2/16/21.

import UIKit

class ViewController: UIViewController {
    
    enum Picker: String, CaseIterable {
        case Low = "low"
        case Smal  = "smal"
        case Medium = "med"
        case Large = "large"
        
        var quality: String {
            switch self {
            case .Low:
                return "t"
            case .Smal:
                return "m"
            case .Medium:
                return "z"
            case .Large:
                return "t"
            }
        }
    }
    
    @IBOutlet weak var qualityPicker: UIPickerView!
    @IBOutlet weak var imagesTableView: UITableView!
    @IBOutlet weak var pageLabel: UITextField!
    @IBOutlet weak var perPageLabel: UITextField!
    
    let userDefaults = UserDefaults()
    let imageCache = ImageProvider()
    var photos: [PhotoCellModel] = []
    var imagesLingArray: [String] = []
    var pickerData = [Picker.Low, Picker.Smal, Picker.Medium, Picker.Large]
    var pickerChoose: String?
    var page = "1"
    var perPage = "10"
    var quality: String {
        var quality = String()
        if let value = userDefaults.value(forKey: "quality") as? String {
            quality = value
        } else {
            quality = pickerChoose ?? "t"
        }
        return quality
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableData()
        imagesTableView.delegate = self
        imagesTableView.dataSource = self
        qualityPicker.dataSource = self
        qualityPicker.delegate = self
        imagesTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        imagesTableView.accessibilityIdentifier = "imageTable"
        pageLabel.accessibilityIdentifier = "pageLabel"
        perPageLabel.accessibilityIdentifier = "perPageLabelLabel"
        pageLabel.text = pageC
        perPageLabel.text = perPageC


    }
    
    @IBAction func reloadButton(_ sender: Any) {
        page = pageLabel.text!
        perPage = perPageLabel.text!
        userDefaults.setValue(page, forKey: "page")
        userDefaults.setValue(perPage, forKey: "perPage")
        userDefaults.setValue(pickerChoose, forKey: "quality")
        setTableData()
        imagesTableView.reloadData()
    }
    
    func setTableData() {
        loadData{ [weak self] (list, error) in
            self?.photos = list ?? []
            DispatchQueue.main.async { [weak self] in
                self?.imagesTableView.reloadData()
            }
        }
    }
    
    func loadData(_ completion: (([PhotoCellModel]?, Error?)->())?) {
        let requestManager = MakeRequest()
        requestManager.request(for: .getResent(type: Photos.self), completed: { [self] result in
            switch result {
            case.success (let array):
                var tempArray: [PhotoCellModel] = []
                var imagesInfo: [PhotosInfo] = []
                imagesInfo = array.filter{$0.photos?.photo != nil}.reduce(into: imagesInfo) { (r, f ) in
                    r.append(contentsOf: (f.photos?.photo)!)
                    tempArray = r.map {
                        PhotoCellModel(imageURL: URL(string: "https://live.staticflickr.com/\($0.server!)/\($0.id!)_\($0.secret!)_\(quality).jpg")!, title: $0.title!)
                    }
                    print(tempArray)
                }
                completion?(tempArray, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
        )}
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let image = photos[indexPath.row]
        let cell = imagesTableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        let indexPath = indexPath
        let queue = DispatchQueue.global(qos: .background)
        queue.async { [self] in
            let urlString = image.imageURL?.absoluteString
            let url = URL(string: urlString!)
            
            imageCache.loadData(url: url!) { imageUI, error  in
                DispatchQueue.main.async {
                    guard let cellIndexPath = tableView.indexPath(for: cell),
                          cellIndexPath == indexPath else {
                        return
                    }
                    cell.imageViewXib.image = UIImage(data: imageUI!)
                    cell.textLabelXib.text = image.title
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
        vc.collectionArray = photos
        vc.indexPath = indexPath
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Picker.allCases.count
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Picker.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerChoose = Picker.allCases[row].quality
    }
}



