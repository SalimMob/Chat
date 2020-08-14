//
//  User.swift
//  Chat
//
//  Created by Salim Maalouf on 8/12/20.
//

import UIKit

class GenericViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
}


extension GenericViewController {
    public func getStoryboard(withName: String) -> UIStoryboard {
        return UIStoryboard(name: withName, bundle: nil)
    }
    
    // Get with Storyboard
    public func getViewController<T: UIViewController>(object: T.Type, forViewControllerId: String, andStoryboardName: String) -> T {
        let storyboard = getStoryboard(withName: andStoryboardName)
        return storyboard.instantiateViewController(withIdentifier: forViewControllerId) as! T
    }
    
    // Get with Nib
    public func getViewController<T: UIViewController>(fromNib: T.Type, forViewControllerId: String) -> T {
        return T(nibName: forViewControllerId, bundle: nil)
    }
    
    // Present with Storyboard
    public func present(viewController: UIViewController, fromViewController: UIViewController) {
        fromViewController.present(viewController, animated: true, completion: nil)
    }
    
    // Push with Storyboard
    public func push(viewController: UIViewController, fromViewController: UIViewController) {
        fromViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    public func dismiss(viewController: UIViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    public func pop(viewController: UIViewController) {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    public func popToRootViewController(fromViewController: UIViewController) {
        fromViewController.navigationController?.popToRootViewController(animated: true)
    }
    
    public func popToViewController(withIndex: Int, fromViewController: UIViewController) {
        fromViewController.navigationController?.popToViewController((fromViewController.navigationController?.viewControllers[withIndex])!, animated: true)
    }
    
    public func topViewController(viewController: UIViewController?) -> UIViewController? {
        var rootVC = viewController
        if rootVC == nil {
            rootVC = UIApplication.shared.keyWindow?.rootViewController
        }
        if rootVC?.presentedViewController == nil {
            return rootVC
        }
        if let presented = rootVC?.presentedViewController {
            if presented.isKind(of: UINavigationController.self) {
                let navigationController = presented as! UINavigationController
                return navigationController.viewControllers.last!
            }
            return topViewController(viewController: presented)
        }
        return nil
    }
    
    public func showAlert(title: String?,
                          message: String? = nil,
                          okTitle: String? = nil,
                          cancelTitle: String? = nil,
                          okHandler: ((UIAlertAction) -> ())? = nil,
                          cancelHandler: ((UIAlertAction) -> ())? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if okTitle != nil {
            let actionOk = UIAlertAction(title: okTitle, style: .default, handler: okHandler)
            alertController.addAction(actionOk)
        }
        if cancelTitle != nil {
            let actionCancel = UIAlertAction(title: cancelTitle, style: .default, handler: cancelHandler)
            alertController.addAction(actionCancel)
        }
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    public func configure(tableView: UITableView, withCustomCellIdentifier: String, in viewController: UIViewController) {
        tableView.dataSource = viewController as? UITableViewDataSource
        tableView.delegate = viewController as? UITableViewDelegate
        tableView.register(UINib(nibName: withCustomCellIdentifier, bundle: nil), forCellReuseIdentifier: withCustomCellIdentifier)
        tableView.tableFooterView = UIView() // For removing the extra empty spaces of TableView below
    }
    
    public func configure(tableView: UITableView, withHeaderFooterViewIdentifier: String) {
        tableView.register(UINib(nibName: withHeaderFooterViewIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: withHeaderFooterViewIdentifier)
    }
    
    public func setRowHeight(for tableView: UITableView, value: CGFloat) {
        tableView.rowHeight = value
    }
    
    public func openURL(forScheme: String) {
        if let url = URL(string: forScheme) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],
                                          completionHandler: {
                                            (success) in
                                            print("Open \(forScheme): \(success)")
                                          })
            } else {
                let success = UIApplication.shared.openURL(url)
                print("Open \(forScheme): \(success)")
            }
        }
    }
    
    public func call(withPhoneNumber: String) {
        openURL(forScheme: "tel://\(withPhoneNumber)")
    }
    
    struct Constants {
        static let APP_TITLE            = "Chat"
        static let OK_TITLE             = "OK"
        static let CANCEL_TITLE         = "Cancel"
    }
    
    struct Storyboard {
        static let Main                 = "Main"
        static let Studios              = "Studios"
    }
    
}
