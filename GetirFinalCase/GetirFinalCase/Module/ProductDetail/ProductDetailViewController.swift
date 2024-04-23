//
//  ProductDetailViewController.swift
//  GetirFinalCase
//
//  Created by Eren Korkmaz on 21.04.2024.
//

import UIKit

protocol ProductDetailProtocol {
    func configure()
    func configureButtons()
}
protocol ProductDetailDelegate {
    
    func activateBasketView()
    func DeactivateBasketView()
    
    func addHorizontalItem(add : HorizontalProduct)
    func addVerticalItem(add : VerticalProduct)
    
    func deleteHorizontalItem()
    func deleteVerticalItem()
    

}

class ProductDetailViewController: UIViewController {

   
    @IBOutlet weak var dismissButton: UIButton!
    
    @IBOutlet weak var basketView: UIView!
    @IBOutlet weak var basketLabel: UILabel!
    @IBOutlet weak var basketImageView: UIImageView!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var attributeLabel: UILabel!
    
    @IBOutlet weak var sepeteEkleButton: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    var horizontalProduct : HorizontalProduct?
    var verticalProduct : VerticalProduct?
    
    var count = 0
    
    var delegate : ProductDetailDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configure()
        configureButtons()
        
        
    }
    

    @IBAction func dismissButtonClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func sepeteEkleButtonClicked(_ sender: Any) {
        
    }
    @IBAction func addButtonClicked(_ sender: Any) {
        
        
        delegate?.addHorizontalItem(add: self.horizontalProduct!)
        
        ListingViewController().basket.horizontalProduct?.append(self.horizontalProduct!)
        
        
        delegate?.activateBasketView()
        self.basketView.isHidden = false
        
        self.containerView.isHidden = false
        self.addButton.isHidden = false
        self.deleteButton.isHidden = false

        self.count += 1
        countLabel.text = String(count)
        
    }
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        if count > 0 {
            count -= 1
            self.countLabel.text = String(count)
        }else {
            self.basketView.isHidden = true
            delegate?.DeactivateBasketView()
        }
       
//        print("delete: \(ListingViewController().basket.horizontalProduct)")
    }
    
}

extension ProductDetailViewController: ProductDetailProtocol{
    func configureButtons() {
        // TODO: butonlar doğru çalışmıyor -->  containerView.removeFromSuperview() çözüm yöntermi bu
        self.containerView.isHidden = false
        self.addButton.isHidden = false
        self.deleteButton.isHidden = false
        self.sepeteEkleButton.isHidden = true
    }
    
    
    func configure() {
        
        self.basketView.isHidden = true
        basketView.layer.cornerRadius = 10
        basketImageView.layer.cornerRadius = 10
        
        if self.horizontalProduct != nil {
            if horizontalProduct?.imageURL != nil {
                imageView.load(url: URL(string: horizontalProduct?.imageURL ?? "https://cdn.getir.com/marketing/Getir_Logo_1621812382342.png")! )
            } else {
                imageView.load(url: URL(string: horizontalProduct?.squareThumbnailURL ?? "https://cdn.getir.com/marketing/Getir_Logo_1621812382342.png")! )
            }
            self.priceLabel.text = horizontalProduct?.priceText
            self.nameLabel.text = horizontalProduct?.name
            self.attributeLabel.text = horizontalProduct?.shortDescription ?? ""
            
        }else if self.verticalProduct != nil{
            if verticalProduct?.imageURL != nil {
                imageView.load(url: URL(string: verticalProduct?.imageURL ?? "https://cdn.getir.com/marketing/Getir_Logo_1621812382342.png")! )
            } else {
                imageView.load(url: URL(string: verticalProduct?.thumbnailURL ?? "https://cdn.getir.com/marketing/Getir_Logo_1621812382342.png")! )
            }
            self.priceLabel.text = verticalProduct?.priceText
            self.nameLabel.text = verticalProduct?.name
            self.attributeLabel.text = verticalProduct?.shortDescription ?? ""
        }else {
            
        }
    }
    
}


