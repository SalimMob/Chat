//
//  EventsTableViewCell.swift
//  Athena
//
//  Created by Salim Maalouf on 4/5/20.
//  Copyright © 2020 Salim Maalouf. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var ivPicture: UIImageView!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewContainer.layer.cornerRadius = 5.0
        viewContainer.layer.borderWidth = 0.3
        viewContainer.layer.borderColor = UIColor.gray.cgColor
        viewContainer.layer.masksToBounds = true
        ivPicture.layer.cornerRadius = ivPicture.bounds.width / 2
        ivPicture.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(user: User) {
        lblTitle.text = user.firstname
        lblDesc.text = user.lastName
//        ivPicture.sd_setImage(with: URL(string: ServerInterface.IMAGES_URL + art.imgName!), placeholderImage: UIImage(named: "placeholder.png"))
    }
}
