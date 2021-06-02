//
//  PostTableViewCell.swift
//  CBook
//
//  Created by Arlin Ropero on 31/05/21.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var box: UIView!
    @IBOutlet weak var sheet: UIImageView!
    @IBOutlet weak var miniSheet: UIImageView!
    @IBOutlet weak var borderBox: UIView!
    @IBOutlet weak var heartButton: UIButton!
    
    var post: Post?
    var callback: (()->Void)?
    
    func initWithData(_ post: Post){
        titleLable.text = post.title
        bodyLabel.text = post.body
        self.post = post
        heartButton.setImage(post.isFavorite ? UIImage(systemName: "suit.heart.fill"):UIImage(systemName: "suit.heart"), for: .normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let trees: [UIImage] = [#imageLiteral(resourceName: "sheet5"), #imageLiteral(resourceName: "sheet2"), #imageLiteral(resourceName: "sheet1"), #imageLiteral(resourceName: "sheet4"), #imageLiteral(resourceName: "sheet3")]
        sheet.image = trees[Int.random(in: 0..<trees.count)].alpha(0.2)
        miniSheet.image = trees[Int.random(in: 0..<trees.count)]
        box.layer.cornerRadius = 20
        
        borderBox.layer.cornerRadius = 20
        borderBox.layer.borderColor = #colorLiteral(red: 0.01176470588, green: 0.5960784314, blue: 0.6196078431, alpha: 1)
        borderBox.layer.borderWidth = 1
        borderBox.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]

    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        // invoke superclass implementation
        super.prepareForReuse()
        // reset (hide) the checkmark label
        heartButton.setImage(post!.isFavorite ? UIImage(systemName: "suit.heart.fill"):UIImage(systemName: "suit.heart"), for: .normal)

    }
    
}
