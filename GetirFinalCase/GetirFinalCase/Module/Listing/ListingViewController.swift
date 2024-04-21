//
//  ViewController.swift
//  GetirFinalCase
//
//  Created by Eren Korkmaz on 10.04.2024.
//

import UIKit

protocol ListingViewControllerProtocol: AnyObject {
    // TODO: yap
    func setupNavigationBar()
    func setupHorizontalScrollView()
    func setupVerticalScrollView()
}

class ListingViewController: BaseViewController {
    
    
    @IBOutlet weak var basketView: UIView!
    
    @IBOutlet weak var basketLabel: UILabel!
    @IBOutlet weak var basketImageView: UIImageView!
    @IBOutlet weak var horizontalCollectionView: UICollectionView!
    
    @IBOutlet weak var verticalCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupHorizontalScrollView()
        setupVerticalScrollView()
        
        basketView.layer.cornerRadius = 10
        basketImageView.layer.cornerRadius = 10
        
        let realURL = URL(string: "https://65c38b5339055e7482c12050.mockapi.io/api/suggestedProducts")!
        CardRepository().haberleriIndir(url: realURL) { (data) in
            print(data?.first?.products.first?.name)
            
        }
        
//            let data = CardRepository().getHorizontalCardData()
//            print(data?.first?.name ?? "asd")
        
        
    }
    var presenter : ListingPresenterProtocol?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewDidLoad()
    }
}

extension ListingViewController: ListingViewControllerProtocol {
    func setupHorizontalScrollView() {
        // TODO: setup horizontal
        horizontalCollectionView.delegate = self
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.showsHorizontalScrollIndicator = false
        
        horizontalCollectionView.register(UINib(nibName: "HorizontalCollectionViewCell", bundle: nil) , forCellWithReuseIdentifier: "horizontalCell")
    }
    
    func setupVerticalScrollView() {
        // TODO: setup vertical
        verticalCollectionView.dataSource = self
        verticalCollectionView.delegate = self
        verticalCollectionView.register(UINib(nibName: "VerticalCollectionViewCell", bundle: nil) , forCellWithReuseIdentifier: "verticalCell")

    }
    
    func setupNavigationBar() {
        let rightButton = UIBarButtonItem(image: .add,
                                        style: .plain,
                                        target: self,
                                        action: #selector(BarButtonAction)
        )
    }
    
    @objc func BarButtonAction() {
        
    }
}
// MARK: CollcetionView
extension ListingViewController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.horizontalCollectionView {
            return 5
        }else {
            return 15
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.horizontalCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "horizontalCell", for: indexPath) as! HorizontalCollectionViewCell
            
            cell.priceLabel.text = "₺ 990"
            cell.NameLabel.text = "deneme"
            cell.attributeLabel.text = "attribue"
            
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "verticalCell", for: indexPath) as! VerticalCollectionViewCell
            cell.backgroundColor = .blue
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.horizontalCollectionView {
            let size = (collectionView.frame.size.width)
            return CGSize(width: size - 285, height: 170)
        }else {
            let size = (collectionView.frame.size.width - 25)/3
            // TODO: cell yamuk
            return CGSize(width: size, height: (collectionView.frame.height - 10)/3)
        }
    }
}

