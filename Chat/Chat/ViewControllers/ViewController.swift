//
//  ViewController.swift
//  Chat
//
//  Created by Salim Maalouf on 8/12/20.
//

import UIKit

class UsersViewController: GenericViewController {

    @IBOutlet weak var tvUsers: UITableView!
    var refreshControl: UIRefreshControl!
    let artTableViewCellIdentifier = "ArtTableViewCell"
    var arrayOfUsers = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.        // Do any additional setup after loading the view.
        configure(tableView: tvUsers, withCustomCellIdentifier: artTableViewCellIdentifier, in: self)
        setRowHeight(for: tvUsers, value: 100.0)
        tvUsers.separatorStyle = .none
        addRefreshControl()
    }
    
    func addRefreshControl() {
        refreshControl = UIRefreshControl()
//        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Data...")
        if #available(iOS 10.0, *) {
            tvUsers.refreshControl = refreshControl
        } else {
            tvUsers.addSubview(refreshControl)
        }
    }
}


// MARK: - Table view data source

extension UserViewController: UITableViewDataSource {
    
    // Rows /////////////////////////////////////////////////////////////////
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let artTableViewCell = tableView.dequeueReusableCell(withIdentifier: artTableViewCellIdentifier, for: indexPath) as! UsersTableViewCell
        artTableViewCell.configure(art: arrayOfArts[indexPath.row])
        return artTableViewCell
    }
}


// MARK: - Table view delegate

extension UsersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // To deselect after selection
        //        tableView.deselectRow(at: indexPath, animated: true)
        let detailsViewController = getViewController(object: DetailsViewController.self, forViewControllerId: "DetailsViewController", andStoryboardName: Storyboard.Main)
        detailsViewController.obj = arrayOfArts[indexPath.row]
        push(viewController: detailsViewController, fromViewController: self)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if refreshControl.isRefreshing {
            getData()
        }
    }
}
