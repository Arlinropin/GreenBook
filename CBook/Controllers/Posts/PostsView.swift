//
//  PostsView.swift
//  CBook
//
//  Created by Arlin Ropero on 31/05/21.
//  
//

import Foundation
import UIKit

class PostsView: BaseController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var comeBackButton: UIButton!
    @IBOutlet weak var userInfoButton: UIButton!
    
    // MARK: Properties
    var presenter: PostsPresenterProtocol?
    var posts: [Post] = []
    var user: User?
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        titleLabel.text = "Posts de " + user!.name
        comeBackButton.layer.cornerRadius = comeBackButton.frame.height / 2
        userInfoButton.layer.cornerRadius = comeBackButton.frame.height / 2
        table.register(UINib(nibName: CellType.POST_CELL.rawValue, bundle: Bundle.main),forCellReuseIdentifier: CellType.POST_CELL.rawValue)
        Navigation.showSpinner()
        presenter!.getPosts(id: user!.id, callbackSuccess: { [self] response in
            Navigation.closeSpinner()
            posts = response
            table.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CellType.POST_CELL.rawValue, for: indexPath) as! PostTableViewCell
        cell.initWithData(post)
        cell.heartButton.tag = indexPath.row
        cell.heartButton.addTarget(self, action: #selector(setFavorite(_:)), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    
    @objc func setFavorite(_ sender:UIButton){
        self.posts[sender.tag].isFavorite = !self.posts[sender.tag].isFavorite
        sender.setImage(self.posts[sender.tag].isFavorite ? UIImage(systemName: "suit.heart.fill"):UIImage(systemName: "suit.heart"), for: .normal)
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        onClickBack()
    }
    @IBAction func seeUserInfo(_ sender: UIButton) {
        Navigation.showPersonalDataView(user: user!)
    }
}

extension PostsView: PostsViewProtocol {
    // TODO: implement view output methods
}
