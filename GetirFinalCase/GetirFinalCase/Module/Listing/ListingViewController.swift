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
        horizontalCollectionView.delegate = self
        horizontalCollectionView.dataSource = self
        
        horizontalCollectionView.isScrollEnabled = true

        
//        verticalCollectionView.dataSource = self
//        verticalCollectionView.delegate = self
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
    }
    
    func setupVerticalScrollView() {
        // TODO: setup vertical
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.horizontalCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "horizontalCell", for: indexPath) as! HorizontalCollectionViewCell
            cell.backgroundColor = .red
            
            return cell
        }
        
        let cell = UICollectionViewCell()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width-15)/3
        return CGSize(width: size, height: size)
    }
    
    
    
}

