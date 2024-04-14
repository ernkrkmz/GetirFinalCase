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

    @IBOutlet weak var horizontalCollectionView: UICollectionView!
    
    @IBOutlet weak var verticalCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupHorizontalScrollView()
        setupVerticalScrollView()
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
            cell.backgroundColor = .red
            cell.priceLabel.text = "99 TL"
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
            return CGSize(width: size, height: 170)
        }else {
            let size = (collectionView.frame.size.width - 25)/3
            // TODO: cell yamuk
            return CGSize(width: size, height: (collectionView.frame.height - 10)/3)
        }
    }
    
    
    
}

