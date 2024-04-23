//
//  HorizontalCollectionViewCell.swift
//  GetirFinalCase
//
//  Created by Eren Korkmaz on 10.04.2024.
//

import UIKit

protocol HorizontalCollectionViewCellDelegate {
    
    func activateBaskeView()
    func deactivateBasketView()
    
    func addHorizontalProduct(product : HorizontalProduct)
    func deleteHorizontalProduct(product : HorizontalProduct)
}

class HorizontalCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageview: UIImageView!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var attributeLabel: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var countView: UIView!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var countLabel: UILabel!
    
    
    var count = 0
    var horizontalProduct : HorizontalProduct?
    
    var delegate : HorizontalCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configure()
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        self.countView.isHidden = false
        self.deleteButton.isHidden = false
        self.count += 1
        countLabel.text = String(self.count)
        
        delegate?.activateBaskeView()
        delegate?.addHorizontalProduct(product: self.horizontalProduct!)
        
    }
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        if self.count < 1 {
            self.count -= 1
            self.countView.isHidden = true
            self.deleteButton.isHidden = true
            delegate?.deactivateBasketView()
        } else {
            self.count -= 1
            countLabel.text = String(self.count)
            delegate?.deleteHorizontalProduct(product: self.horizontalProduct!)
            if self.count == 0{
                self.countView.isHidden = true
                self.deleteButton.isHidden = true
            }
        }
        
    }
}

extension HorizontalCollectionViewCell {
    
    func configure() {
        countView.isHidden = true
        deleteButton.isHidden = true
        
        addButton.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        addButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        addButton.layer.shadowOpacity = 1.0
        addButton.layer.shadowRadius = 0.0
        addButton.layer.masksToBounds = false
        addButton.layer.cornerRadius = 3.0
        
        imageview.layer.borderWidth = 1
        imageview.layer.cornerRadius = 15
        imageview.layer.borderColor = CGColor(red: 0.749, green: 0.749, blue: 0.749, alpha: 1.0)
    }
}



