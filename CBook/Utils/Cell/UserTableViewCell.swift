//
//  UserTableViewCell.swift
//  CBook
//
//  Created by Arlin Ropero on 31/05/21.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var tree: UIImageView!
    @IBOutlet weak var box: UIView!
    @IBOutlet weak var greenBox: UIView!
    
    var callback: ((User)->Void)?
    var user: User?
    
    func initWithData(_ user: User){
        nameLabel.text = user.name
        phoneLabel.text = user.phone
        emailLabel.text = user.email
        self.user = user
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let trees: [UIImage] = [#imageLiteral(resourceName: "tree1"), #imageLiteral(resourceName: "tree3"), #imageLiteral(resourceName: "tree2")]
        tree.image = trees[Int.random(in: 0..<trees.count)]
        box.layer.cornerRadius = 20
        
        greenBox.layer.cornerRadius = 20
        greenBox.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]

    }

    @IBAction func seePosts(_ sender: UIButton) {
        callback!(user!)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
