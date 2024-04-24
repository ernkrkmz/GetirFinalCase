//
//  BasketViewController.swift
//  GetirFinalCase
//
//  Created by Eren Korkmaz on 24.04.2024.
//

import UIKit

protocol BasketViewControllerDelegate {
    func DeleteBasket()
}


class BasketViewController: BaseViewController {

    
    @IBOutlet weak var dissmisButton: UIButton!
    @IBOutlet weak var trashButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var finalPriceLabel: UILabel!
    @IBOutlet weak var complateOrderButton: UIButton!
    
    var basket = Basket()
    
    var merged : [AnyObject] = []
    
    var totalPrice = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 110
        tableView.register(UINib(nibName: "BasketTableViewCell", bundle: nil), forCellReuseIdentifier: "myTableViewCell")
        
        merged = (basket.horizontalProduct! as [AnyObject] ) + (basket.verticalProduct! as [AnyObject])
        
    }
    
    @IBAction func complateOrderButtonClicked(_ sender: Any) {
        
    }
    @IBAction func dissmissButtonClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func trashButtonClicked(_ sender: Any) {
        
        self.basket.horizontalProduct = []
        self.basket.verticalProduct = []
        self.merged = []
        
        self.finalPriceLabel.text = "₺0,0"
        tableView.reloadData()
    }
    
}

// MARK: - TableView
extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((self.basket.horizontalProduct?.count ?? 0) + (self.basket.verticalProduct?.count ?? 0))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myTableViewCell", for: indexPath) as! BasketTableViewCell
        
        if let item = merged[indexPath.row] as? HorizontalProduct {
            cell.nameLabel.text = item.name
            cell.priceLabel.text = item.priceText
            cell.attributeLabel.text = item.shortDescription
            self.totalPrice += (item.price ?? 0.0)
            if item.imageURL != nil {
                
                cell.imageView?.imageFromServerURL(urlString: item.imageURL!, PlaceHolderImage: UIImage.init(named: "Getir_Logo_Circle")!)
                
            }else{
                cell.imageView?.imageFromServerURL(urlString: item.squareThumbnailURL!, PlaceHolderImage: UIImage.init(named: "Getir_Logo_Circle")!)
            }
        }
        else if let item = merged[indexPath.row] as? VerticalProduct {
            cell.nameLabel.text = item.name
            cell.priceLabel.text = item.priceText
            cell.attributeLabel.text = item.shortDescription
            self.totalPrice += (item.price ?? 0.0)
            if item.imageURL != nil {
                
                cell.imageView?.imageFromServerURL(urlString: item.imageURL!, PlaceHolderImage: UIImage.init(named: "Getir_Logo_Circle")!)
                

            }else{
                cell.imageView?.imageFromServerURL(urlString: item.thumbnailURL!, PlaceHolderImage: UIImage.init(named: "Getir_Logo_Circle")!)

            }
        }
        self.finalPriceLabel.text = "₺ \(String(totalPrice))"
        return cell
    }
    
    
}
