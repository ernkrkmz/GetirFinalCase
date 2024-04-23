//
//  BasketViewController.swift
//  GetirFinalCase
//
//  Created by Eren Korkmaz on 24.04.2024.
//

import UIKit



class BasketViewController: BaseViewController {

    
    @IBOutlet weak var dissmisButton: UIButton!
    @IBOutlet weak var trashButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var finalPriceLabel: UILabel!
    @IBOutlet weak var complateOrderButton: UIButton!
    
    var basket = Basket()
    
    var merged : [AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 110
        tableView.register(UINib(nibName: "BasketTableViewCell", bundle: nil), forCellReuseIdentifier: "myTableViewCell")
        
        merged = (basket.horizontalProduct! as [AnyObject] ) + (basket.verticalProduct! as [AnyObject])
        
    }
    
    @IBAction func complateOrderButtonClicked(_ sender: Any) {
        print(merged)
    }
    @IBAction func dissmissButtonClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

// MARK: - TableView
extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((self.basket.horizontalProduct?.count ?? 0) + (self.basket.verticalProduct?.count ?? 0))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myTableViewCell", for: indexPath) as! BasketTableViewCell
        
        return cell
    }
    
    
}
