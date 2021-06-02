//
//  ModalUserData.swift
//  CBook
//
//  Created by Arlin Ropero on 1/06/21.
//

import UIKit

class ModalUserData: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var personalDataUser: UILabel!
    @IBOutlet weak var box: UIView!
    @IBOutlet weak var greenBox: UIView!
    
    var user: User?
    var callback: (()->Void)?
    var images: [UIImageView] = []
    
    private static var view: ModalUserData?
    private static var viewBack = UIView()
    
    override func viewDidLoad() {
        let usr = user!
        nameLabel.text = usr.name
        
        let de = "Email: ".B()
        let dE = "\(usr.email)\n".N()
        let dd = "Dirección: ".B()
        let dD = "\(usr.address.street) - \(usr.address.suite) - \(usr.address.city))\n".N()
        let dp = "Número de teléfono: ".B()
        let dP = "\(usr.phone)\n".N()
        let dw = "Website: ".B()
        let dW = "\(usr.website)\n".N()
        let dc = "Empresa: ".B()
        let dC = "\(usr.company.name)\n".N()
        de.append(dE); de.append(dd); de.append(dD); de.append(dp); de.append(dP); de.append(dw); de.append(dW); de.append(dc); de.append(dC)
        personalDataUser.attributedText = de

        
        super.viewDidLoad()
        let trees: [UIImage] = [#imageLiteral(resourceName: "sheet5"), #imageLiteral(resourceName: "sheet2"), #imageLiteral(resourceName: "sheet1"), #imageLiteral(resourceName: "sheet4"), #imageLiteral(resourceName: "sheet3")]
        let positions: [Int] = Array(0..<trees.count).shuffled() + Array(0..<trees.count).shuffled() + Array(0..<trees.count).shuffled()
        for index in 0..<trees.count * 3 {
            images.append(UIImageView())
            let image = trees[positions[index]].alpha(0.2)
            let imageRotated = image.rotate(radians: CGFloat.random(in: (0...3.14)))
            images[index].image = imageRotated
            images[index].contentMode = .scaleToFill
            let screenFrame = UIScreen.main.bounds
            let constantSize = CGFloat(50)
            images[index].frame = CGRect(x: CGFloat.random(in: (0...screenFrame.width - constantSize)), y: CGFloat.random(in: (0...screenFrame.height - constantSize)), width: constantSize, height: constantSize)
            box.addSubview(images[index])
        }
        
        box.layer.cornerRadius = 20
        box.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        greenBox.layer.cornerRadius = 20
        greenBox.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        

    }
    
    @IBAction func close(_ sender: UIButton) {
        callback!()
    }
    
    static func showPersonalDataView(user: User, vc: UIViewController){
        viewBack.frame = UIScreen.main.bounds
        viewBack.backgroundColor = UIColor.black.withAlphaComponent(0.7)

        view = ModalUserData()
        view!.user = user
        view!.view.frame = UIScreen.main.bounds
        view!.callback = { closePersonalDataView() }
        viewBack.addSubview(view!.view)
        UIView.animate(withDuration: 0.3, animations: {viewBack.alpha = 1.0}, completion: {(value: Bool) in vc.view.addSubview(viewBack) })
    }
    
    static func closePersonalDataView(){
        UIView.animate(withDuration: 0.1, animations: {viewBack.alpha = 0.0}, completion: {(value: Bool) in
            viewBack.removeFromSuperview()
        })
    }
    
}
