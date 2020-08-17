//
//  ChatViewController.swift
//  Chat
//
//  Created by Salim Maalouf on 8/13/20.
//

import UIKit
import CoreData

class ChatViewController: GenericViewController {
    
    @IBOutlet weak var tvMsg: UITableView!
    let chatTableViewCellIdentifier = "ChatTableViewCell"
    @IBOutlet var tfMsg: UITextField!
    var arrayOfMessages: [Message] = []
    var arrayOfUsers1: [NSManagedObject] = []
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configure(tableView: tvMsg, withCustomCellIdentifier: chatTableViewCellIdentifier, in: self)
        setRowHeight(for: tvMsg, value: 100.0)
        tvMsg.separatorStyle = .none
        fillArray()
        title = user!.firstName + " " + user!.lastName
    }
    
    func fillArray() {
        arrayOfMessages = [
            Message(id: 0, text: "user1"),
            Message(id: 1, text: "user2"),
            Message(id: 3, text: "user3"),
            Message(id: 4, text: "user4"),
            Message(id: 5, text: "user5"),
            Message(id: 6, text: "user6"),
            Message(id: 7, text: "user7")
        ]
        
        for i in 0 ..< arrayOfMessages.count {
            save(message: arrayOfMessages[i])
        }
        
        arrayOfUsers1 = CoreDataManager.shared.getData(entityName: "MessageCD")
    }
    
    func save(message: Message) {
        let managedContext = CoreDataManager.shared.coreDataClass.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MessageCD", in: managedContext)!
        let userCD = NSManagedObject(entity: entity, insertInto: managedContext)
        userCD.setValue(message.id, forKeyPath: "id")
        userCD.setValue(message.text, forKeyPath: "text")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    @IBAction func btnSend(_ sender: Any) {
        
    }
}


// MARK: - Table view data source

extension ChatViewController: UITableViewDataSource {
    
    // Rows /////////////////////////////////////////////////////////////////
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfUsers1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chatTableViewCell = tableView.dequeueReusableCell(withIdentifier: chatTableViewCellIdentifier, for: indexPath) as! ChatTableViewCell
        let messageCD = arrayOfUsers1[indexPath.row]
        var message = Message(id: 0, text: "")
        message.text = messageCD.value(forKeyPath: "text") as! String
        return chatTableViewCell
    }
}
