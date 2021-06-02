//
//  UsersView.swift
//  CBook
//
//  Created by Arlin Ropero on 31/05/21.
//  
//

import Foundation
import UIKit

class UsersView: BaseController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var textfield: UITextField!
    
    // MARK: Properties
    var presenter: UsersPresenterProtocol?
    var users: [User] = []
    var dataSafe: [User] = []
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        textfield.layer.cornerRadius = textfield.frame.height / 2
        textfield.layer.borderWidth = 3
        textfield.layer.borderColor = #colorLiteral(red: 0.7803921569, green: 0.9921568627, blue: 1, alpha: 1)
        textfield.delegate = self
        
        table.register(UINib(nibName: CellType.USER_CELL.rawValue, bundle: Bundle.main),forCellReuseIdentifier: CellType.USER_CELL.rawValue)
        Navigation.showSpinner()
        presenter!.getUsers(callbackSuccess: { [self] response in
            Navigation.closeSpinner()
            dataSafe = response
            users = response
            table.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CellType.USER_CELL.rawValue, for: indexPath) as! UserTableViewCell
        cell.initWithData(user)
        cell.callback = {response in self.seePosts(user: response)}
        cell.selectionStyle = .none
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        Navigation.showPersonalDataView(user: users[indexPath.row])
//    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return true }
        let count = text.count + string.count - range.length
        if (count > 0) {
            users = dataSafe.filter({ $0.name.uppercased().contains(text.uppercased()) })
            table.reloadData()
        } else {
            users = dataSafe
            table.reloadData()
        }
        return true
    }
    
    func seePosts(user: User){
        presenter!.showPosts(user: user)
    }
}

extension UsersView: UsersViewProtocol {
    // TODO: implement view output methods
}
