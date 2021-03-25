//
//  ViewController.swift
//  ColorfulColorado
//
//  Created by Gabo Cuadros Cardenas on 3/21/21.
//

import UIKit
import SDWebImage

class MainViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    //MARK: Variables
    
    private var recentUploads: RecentUploads? {
        didSet {
            DispatchQueue.main.async {
                self.mainCollectionView.reloadData()
            }
        }
    }
    
    private var isFirstLoad = true
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    private let itemsPerRow: CGFloat = 3
    private var errorCellMessage = String(format: Constants.Messages.Errors.error, "")
    private var showingCell: MainViewCollectionViewCells?
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isFirstLoad {
            self.retriveDataForColoradoImages()
            isFirstLoad = false
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // Reload mainCollectionView in order to keep the 3 row layout when the devices rotates
        self.mainCollectionView.reloadData()
    }
    
    // MARK: Functions

    private func setUpCollectionView() {
        self.mainCollectionView.delegate = self
        self.mainCollectionView.dataSource = self
    }
    
    private func retriveDataForColoradoImages() {
        NetworkLayer<RecentUploads>.request(router: .fetchColoradoImages) { (networkResponse) in
            switch networkResponse {
            case .success(let data):
                self.recentUploads = data
            case .failure(let error):
                switch error {
                case .brokenURL:
                    self.errorCellMessage = Constants.Messages.Errors.brokenUrl
                case .error(let thisError):
                    self.errorCellMessage = String(format: Constants.Messages.Errors.error, thisError)
                case .parseError:
                    self.errorCellMessage = Constants.Messages.Errors.parseError
                case .noData:
                    self.errorCellMessage = Constants.Messages.Errors.noData
                }
                print(error.localizedDescription)
                self.simpleAlert(title: Constants.Messages.Errors.ops,
                                 message: error.localizedDescription,
                                 buttonTitle: Constants.Button.ok) { (alert) in
                    alert.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    public func simpleAlert(title: String, message: String,buttonTitle: String, completion: ((UIAlertController) -> Void)?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { (action) in
                if let completion = completion {
                    completion(alert)
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentUploads?.items.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let recentUploads = recentUploads else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.MainViewController.Identifiers.tryAgainCollectionViewCell, for: indexPath) as! ErrorCollectionViewCell
            self.showingCell = .Error
            cell.text.text = errorCellMessage
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.MainViewController.Identifiers.imageWithTitleCollectionViewCell, for: indexPath) as! ImageWithTitleCollectionViewCell
        self.showingCell = .ImageWithTitle
        cell.title.text = recentUploads.items[indexPath.row].title
        if let url = URL(string: recentUploads.items[indexPath.row].media.url),
           let placeholder = UIImage(named: Constants.MainViewController.Images.placeholder){
            cell.image.sd_setImage(with: url, placeholderImage: placeholder, options: .progressiveLoad, completed: nil)
        }
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch showingCell {
        case .ImageWithTitle:
            let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
            let availableWidth = self.mainCollectionView.frame.width - paddingSpace
            let widthPerItem = availableWidth / itemsPerRow
            return CGSize(width: widthPerItem, height: widthPerItem * 1.8)
        default:
            return CGSize(width: self.mainCollectionView.frame.width, height: self.mainCollectionView.frame.height)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

enum MainViewCollectionViewCells {
    case ImageWithTitle
    case Error
}
