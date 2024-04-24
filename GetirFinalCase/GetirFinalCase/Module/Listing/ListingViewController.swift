//
//  ViewController.swift
//  GetirFinalCase
//
//  Created by Eren Korkmaz on 10.04.2024.
//

import UIKit

protocol ListingViewControllerProtocol: AnyObject {
    func setupNavigationBar()
    func setupHorizontalScrollView()
    func setupVerticalScrollView()
    
    func getVerticalData()
    func getHorizontalData()
    
    func updateBasketView()
    
    func updateCardData()
}

class ListingViewController: BaseViewController {
    
    
    @IBOutlet weak var basketView: UIView!
    
    @IBOutlet weak var basketLabel: UILabel!
    @IBOutlet weak var basketImageView: UIImageView!
    @IBOutlet weak var horizontalCollectionView: UICollectionView!
    
    @IBOutlet weak var verticalCollectionView: UICollectionView!
    
    var HorizontalItems : [HorizontalProduct] = []
    var VerticalItems   : [VerticalProduct] = []
    
    var selectedHorizontalItem : HorizontalProduct?
    var selectedVeritcalItem : VerticalProduct?
    
    
    public var basket = Basket()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupHorizontalScrollView()
        setupVerticalScrollView()
        setupNavigationBar()
        
        getHorizontalData()
        getVerticalData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateBasketView()
        //TODO: sonra yap2
        self.horizontalCollectionView.reloadData()

    }
    
    var presenter : ListingPresenterProtocol?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewDidLoad()
    }
}
// MARK: - Setup
extension ListingViewController: ListingViewControllerProtocol {
    func updateCardData() {
        
    }
    
    
    func updateBasketView() {
        var price = Double(basketLabel.text ?? "0.0") ?? 0.0
        
        for horizontalItem in basket.horizontalProduct ?? [] {
            price += Double(horizontalItem.price ?? 0)
        }
        for verticalItem in basket.verticalProduct ?? [] {
            price += Double(verticalItem.price ?? 0)
        }
        self.basketLabel.text = String("₺ \(price)")
        
        if self.basketLabel.text == "0"{
            self.basketView.isHidden = true
        }
    }
    
    func getVerticalData() {
        let horizontalURL = URL(string: "https://65c38b5339055e7482c12050.mockapi.io/api/suggestedProducts")!
        
        CardRepository().getHorizontalItems(url: horizontalURL) { (data) in
            self.HorizontalItems = data?.first?.products ?? []
            DispatchQueue.main.async {
                self.horizontalCollectionView.reloadData()
            }
            
        }
    }
    
    func getHorizontalData() {
        let verticalURL = URL(string: "https://65c38b5339055e7482c12050.mockapi.io/api/products")!

        CardRepository().getVerticalItems(url: verticalURL) { (data) in

            self.VerticalItems = data?.first?.products ?? []
            DispatchQueue.main.async {
                self.verticalCollectionView.reloadData()
            }
            
        }
    }
    
    func setupHorizontalScrollView() {
        horizontalCollectionView.delegate = self
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.showsHorizontalScrollIndicator = false
        
        horizontalCollectionView.register(UINib(nibName: "HorizontalCollectionViewCell", bundle: nil) , forCellWithReuseIdentifier: "horizontalCell")
    }
    
    func setupVerticalScrollView() {
        verticalCollectionView.dataSource = self
        verticalCollectionView.delegate = self
        verticalCollectionView.showsVerticalScrollIndicator = false
        verticalCollectionView.register(UINib(nibName: "VerticalCollectionViewCell", bundle: nil) , forCellWithReuseIdentifier: "verticalCell")

    }
    
    func setupNavigationBar() {
        basketView.isHidden = true
        basketView.layer.cornerRadius = 10
        basketImageView.layer.cornerRadius = 10
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        basketView.addGestureRecognizer(tap)
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        performSegue(withIdentifier: "toBasketVC", sender: nil)
    }
    
}
// MARK: - CollcetionView
extension ListingViewController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.horizontalCollectionView {
            return HorizontalItems.count
        }else {
            return VerticalItems.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.horizontalCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "horizontalCell", for: indexPath) as! HorizontalCollectionViewCell
            
            cell.horizontalBasket = self.basket.horizontalProduct ?? []
            
            cell.horizontalProduct = HorizontalItems[indexPath.row]
            cell.priceLabel.text = HorizontalItems[indexPath.row].priceText ?? ""
            cell.NameLabel.text = HorizontalItems[indexPath.row].name ?? ""
            cell.attributeLabel.text = HorizontalItems[indexPath.row].shortDescription?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            
            cell.delegate = self
            
            if HorizontalItems[indexPath.row].imageURL != nil {
                cell.imageview.load(url: URL(string: HorizontalItems[indexPath.row].imageURL ?? "https://cdn.getir.com/marketing/Getir_Logo_1621812382342.png")!)
            } else {
                cell.imageview.load(url: URL(string: HorizontalItems[indexPath.row].squareThumbnailURL ?? "https://cdn.getir.com/marketing/Getir_Logo_1621812382342.png")!)
            }
            
            
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "verticalCell", for: indexPath) as! VerticalCollectionViewCell
            
            cell.delegate = self
            cell.verticalProduct = VerticalItems[indexPath.row]
            
            cell.priceLabel.text = VerticalItems[indexPath.row].priceText ?? ""
            cell.NameLabel.text = VerticalItems[indexPath.row].name ?? ""
            cell.attributeLabel.text = VerticalItems[indexPath.row].shortDescription?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            
            if VerticalItems[indexPath.row].imageURL != nil {
                cell.imageView.load(url: URL(string: VerticalItems[indexPath.row].imageURL ?? "https://cdn.getir.com/marketing/Getir_Logo_1621812382342.png")!)
            } else {
                cell.imageView.load(url: URL(string: VerticalItems[indexPath.row].thumbnailURL ?? "https://cdn.getir.com/marketing/Getir_Logo_1621812382342.png")!)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.horizontalCollectionView {
            let size = (collectionView.frame.size.width)
            return CGSize(width: size - 285, height: 170)
        }else {
            let size = (collectionView.frame.size.width - 25)/3
            return CGSize(width: size, height: (collectionView.frame.height - 20) / 2.3)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.horizontalCollectionView {
            self.selectedHorizontalItem = HorizontalItems[indexPath.row]
            performSegue(withIdentifier: "toProductDetailVC", sender: nil)
        }else {
            self.selectedVeritcalItem = VerticalItems[indexPath.row]
            performSegue(withIdentifier: "toProductDetailVC", sender: nil)
        }
    }
    
}

// MARK: - Segue
extension ListingViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProductDetailVC"{
            let destination = segue.destination as! ProductDetailViewController
            destination.horizontalProduct = self.selectedHorizontalItem
            destination.verticalProduct = self.selectedVeritcalItem
            destination.basket = self.basket
            destination.delegate = self
        }else if segue.identifier == "toBasketVC" {
            let destination = segue.destination as! BasketViewController
            destination.basket = self.basket
            // TODO: delegate ekle
        }
    }
    
}

// MARK: - ProductDetail Delegate

extension ListingViewController: ProductDetailDelegate {
    
    
    func activateBasketView() {
        self.basketView.isHidden = false
    }
    
    func DeactivateBasketView() {
        self.basketView.isHidden = true
        updateBasketView()
    }
    
    func addHorizontalItem(add: HorizontalProduct) {
        self.basket.horizontalProduct?.append(add)
        updateBasketView()
    }
    
    func addVerticalItem(add: VerticalProduct) {
        basket.verticalProduct?.append(add)
        updateBasketView()
    }
    func deleteHorizontalItem(product: HorizontalProduct) {
        do{
            let index = self.basket.horizontalProduct?.lastIndex(where: { $0.id == product.id })
            if let index = index {
                self.basket.horizontalProduct?.remove(at: index)
            }
        }
        
        updateBasketView()
    }
    
    func deleteVerticalItem(product: VerticalProduct) {
        do{
            let index = self.basket.verticalProduct?.lastIndex(where: { $0.id == product.id })
            if let index = index {
                self.basket.verticalProduct?.remove(at: index)
            }
        }
        updateBasketView()
    }
    
}
// MARK: - HorizontalCollectionViewCell Delegate
extension ListingViewController : HorizontalCollectionViewCellDelegate{
    
    func addHorizontalProduct(product: HorizontalProduct) {
        self.basket.horizontalProduct?.append(product)
        updateBasketView()
    }
    func deleteHorizontalProduct(product: HorizontalProduct) {
        do{
            let index = self.basket.horizontalProduct?.lastIndex(where: { $0.id == product.id })
            self.basket.horizontalProduct?.remove(at: index!)
        }
        
        updateBasketView()
    }
    
    func activateBaskeView() {
        self.basketView.isHidden = false
    }
    func deactivateBasketView() {
        self.basketView.isHidden = true
    }
       
}
// MARK: - VerticalCollectionViewCell Delegate

extension ListingViewController: VerticalCollectionViewCellDelegate {
    
    func addVerticalProduct(product: VerticalProduct) {
        self.basket.verticalProduct?.append(product)
        updateBasketView()
    }
    
    func deleteVerticalProduct(product: VerticalProduct) {
        do{
            let index = self.basket.verticalProduct?.lastIndex(where: { $0.id == product.id })
            if let index = index {
                self.basket.verticalProduct?.remove(at: index)
            }
            updateBasketView()
        }

    }
    
    
}

extension ListingViewController: BasketViewControllerDelegate{
    func DeleteBasket() {
        self.basket = Basket()
    }
    
    
}
