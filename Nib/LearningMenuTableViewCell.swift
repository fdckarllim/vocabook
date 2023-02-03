//
//  LearningMenuTableViewCell.swift
//  vocabook
//
//  Created by Karl Lim on 1/27/23.
//

import UIKit

class LearningMenuTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        accessoryType = .disclosureIndicator
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.00)
        selectedBackgroundView = backgroundView
        
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        print(selected)
        // Configure the view for the selected state
    }
    
    func configureItem(with itemName: String , itemDescription: String) {
        nameLbl.text = itemName
        descriptionLbl.text = itemDescription
    }
}
