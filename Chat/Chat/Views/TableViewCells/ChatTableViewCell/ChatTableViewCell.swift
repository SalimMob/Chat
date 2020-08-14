//
//  ChatTableViewCell.swift
//  Chat
//
//  Created by Salim Maalouf on 8/14/20.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblMsg: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(user: User) {
        lblMsg.text = "asdsd sdvsv vbgbdfbd dtbtre wef"
    }
}
