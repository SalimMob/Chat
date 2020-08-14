//
//  ViewController.swift
//  Chat
//
//  Created by Salim Maalouf on 8/12/20.
//

import UIKit
import Helpers
import CoreData

class UsersViewController: GenericViewController {
    
    @IBOutlet weak var tvUsers: UITableView!
    var refreshControl: UIRefreshControl!
    let userTableViewCellIdentifier = "UserTableViewCell"
    var arrayOfUsers = [User]()
    var arrayOfActiveUsers = [NSManagedObject]()
    let fileName = "users.cst"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.        // Do any additional setup after loading the view.
        configure(tableView: tvUsers, withCustomCellIdentifier: userTableViewCellIdentifier, in: self)
        setRowHeight(for: tvUsers, value: 100.0)
        tvUsers.separatorStyle = .none
        addRefreshControl()
        fillArray()
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
    
    func fillArray() {
        arrayOfUsers = [
            User(id: 0, firstName: "user1", lastName: "user11", imgName: "user"),
            User(id: 1, firstName: "user2", lastName: "user22", imgName: "user"),
            User(id: 2, firstName: "user3", lastName: "user33", imgName: "user"),
            User(id: 3, firstName: "user4", lastName: "user44", imgName: "user"),
            User(id: 4, firstName: "user5", lastName: "user55", imgName: "user"),
            User(id: 5, firstName: "user6", lastName: "user66", imgName: "user"),
            User(id: 6, firstName: "user7", lastName: "user77", imgName: "user"),
            User(id: 7, firstName: "user8", lastName: "user88", imgName: "user")
        ]
        for i in 0 ..< arrayOfUsers.count {
            save(user: arrayOfUsers[i])
        }
        
        arrayOfActiveUsers = CoreDataManager.shared.getData(entityName: "UserCD")
    }
    
    func save(user: User) {
        let managedContext = CoreDataManager.shared.coreDataClass.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "UserCD", in: managedContext)!
        let userCD = NSManagedObject(entity: entity, insertInto: managedContext)
        userCD.setValue(user.id, forKeyPath: "id")
        userCD.setValue(user.firstName, forKeyPath: "firstname")
        userCD.setValue(user.lastName, forKeyPath: "lastname")
        userCD.setValue(user.imgName, forKeyPath: "imgname")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}


// MARK: - Table view data source

extension UsersViewController: UITableViewDataSource {
    
    // Rows /////////////////////////////////////////////////////////////////
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfActiveUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userTableViewCell = tableView.dequeueReusableCell(withIdentifier: userTableViewCellIdentifier, for: indexPath) as! UserTableViewCell
        let userCD = arrayOfActiveUsers[indexPath.row]
        var user = User(id: 0, firstName: "", lastName: "", imgName: "")
        user.firstName = userCD.value(forKeyPath: "firstname") as! String
        user.lastName = userCD.value(forKeyPath: "lastname") as! String
        user.imgName = userCD.value(forKeyPath: "imgname") as! String
        userTableViewCell.configure(user: user)
        return userTableViewCell
    }
}


// MARK: - Table view delegate

extension UsersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // To deselect after selection
        tableView.deselectRow(at: indexPath, animated: true)
        let chatViewController = getViewController(object: ChatViewController.self, forViewControllerId: "ChatViewController", andStoryboardName: Storyboard.Main)
        let userCD = arrayOfActiveUsers[indexPath.row]
        var user = User(id: 0, firstName: "", lastName: "", imgName: "")
        user.firstName = userCD.value(forKeyPath: "firstname") as! String
        user.lastName = userCD.value(forKeyPath: "lastname") as! String
        user.imgName = userCD.value(forKeyPath: "imgname") as! String
        chatViewController.user = user
        push(viewController: chatViewController, fromViewController: self)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if refreshControl.isRefreshing {
            fillArray()
        }
    }
}
