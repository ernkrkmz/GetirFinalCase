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
    
    var HorizontalItems : [HorizontalProduct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 110
        tableView.register(UINib(nibName: "BasketTableViewCell", bundle: nil), forCellReuseIdentifier: "myTableViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "HorizontalCollectionViewCell", bundle: nil) , forCellWithReuseIdentifier: "horizontalCell")
        collectionView.reloadData()
        
        merged = (basket.horizontalProduct! as [AnyObject] ) + (basket.verticalProduct! as [AnyObject])
        
        print(self.HorizontalItems)
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

// MARK: - CollectionView
extension BasketViewController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.HorizontalItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "horizontalCell", for: indexPath) as! HorizontalCollectionViewCell
        
        cell.horizontalProduct = HorizontalItems[indexPath.row]
        cell.priceLabel.text = HorizontalItems[indexPath.row].priceText ?? ""
        cell.NameLabel.text = HorizontalItems[indexPath.row].name ?? ""
        cell.attributeLabel.text = HorizontalItems[indexPath.row].shortDescription?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if HorizontalItems[indexPath.row].imageURL != nil {
            cell.imageview.load(url: URL(string: HorizontalItems[indexPath.row].imageURL ?? "https://cdn.getir.com/marketing/Getir_Logo_1621812382342.png")!)
        } else {
            cell.imageview.load(url: URL(string: HorizontalItems[indexPath.row].squareThumbnailURL ?? "https://cdn.getir.com/marketing/Getir_Logo_1621812382342.png")!)
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width)
        return CGSize(width: size - 285, height: 170)
        
    }
    
    
}
