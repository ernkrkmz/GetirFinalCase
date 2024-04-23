//
//  BasketTableViewCell.swift
//  GetirFinalCase
//
//  Created by Eren Korkmaz on 24.04.2024.
//

import UIKit

protocol BasketTableViewProtocol {
    func configureButtons()
}

class BasketTableViewCell: UITableViewCell {

    
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var attributeLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureButtons()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addButtonclicked(_ sender: Any) {
    }
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
    }
    
}

extension BasketTableViewCell: BasketTableViewProtocol{
    func configureButtons() {
        
    }
    
    
}
