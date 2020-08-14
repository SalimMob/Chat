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
    }
    
    func fillArray() {
        arrayOfMessages = [
            Message(id: 0, ofUser: 0, text: "salimov0"),
            Message(id: 0, ofUser: 0, text: "salimov0"),
            Message(id: 0, ofUser: 0, text: "salimov0"),
            Message(id: 0, ofUser: 0, text: "salimov0"),
            Message(id: 0, ofUser: 0, text: "salimov0"),
            Message(id: 0, ofUser: 0, text: "salimov0"),
            Message(id: 0, ofUser: 0, text: "salimov0")
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
        var message = Message(id: 0, ofUser: 0, text: "salimov0")
        message.text = messageCD.value(forKeyPath: "text") as! String
        return chatTableViewCell
    }
}
