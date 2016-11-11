//
//  MasterViewController.swift
//  JSONMapping
//
//  Created by Ted Conley on 10/20/16.
//  Copyright © 2016 Ted Conley. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Any]()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }

        // sync success
        let (syncSuccessSignal, syncSuccessObserver) = Signal<SyncResponse, NoError>.pipe()
        let syncSuccessSubscriber = Observer<SyncResponse, NoError> { syncResponse in
        }
        syncSuccessSignal.observe(syncSuccessSubscriber)
        
        // handle login errors
        let (loginErrorSignal, loginErrorObserver) = Signal<BPResponse, NoError>.pipe()
        let loginErrorSubscriber = Observer<BPResponse, NoError> { (bpResponseEvent) in
            let bpResponse = bpResponseEvent.value
            print("Login Error: \(bpResponse!.value!)")
        }
        loginErrorSignal.observe(loginErrorSubscriber)
        
        // handle login failures
        let (loginFailureSignal, loginFailureObserver) = Signal<Error, NoError>.pipe()
        let loginFailureSubscriber = Observer<Error, NoError> { (loginErrorEvent) in
            let error = loginErrorEvent.value
            print("Login Failure: \(error!.localizedDescription)")
        }
        loginFailureSignal.observe(loginFailureSubscriber)
        
        // handle login success
        let (loginSuccessSignal, loginSuccessObserver) = Signal<LoginResponse, NoError>.pipe()
        let loginSuccessSubscriber = Observer<LoginResponse, NoError> { (loginResponseEvent) in
            let loginResponse = loginResponseEvent.value
            print("Login Success: \(loginResponse!)")
            
            // perform initial sync
            API.sync(withContext: AppContext.sharedInstance, success: syncSuccessObserver, error: loginErrorObserver, failure: loginFailureObserver)
        }
        loginSuccessSignal.observe(loginSuccessSubscriber)
        
        // new device registration
        let (newDeviceRegistrationSignal, newDeviceRegistrationObserver) = Signal<BPResponse, NoError>.pipe()
        let newDeviceRegistrationSubscriber = Observer<BPResponse, NoError> { (bpResponseEvent) in
            let bpResponse = bpResponseEvent.value
            print("New device registration success: \(bpResponse!)")
        }
        newDeviceRegistrationSignal.observe(newDeviceRegistrationSubscriber)
        
        // perform sync
        let syncInitiateSubscriber = Observer<LoginResponse, NoError> { (bpResponseEvent) in
            //perform sync
            print("Performing sync")
        }
        loginSuccessSignal.observe(syncInitiateSubscriber)
        
        // change password or userName to use login error subscriber
        AppContext.sharedInstance.password = "...."
        AppContext.sharedInstance.userName = "...."
        
        // In ServerWebMethods change "https" to "htttps" or similar to user login failure subscriber

        API.login(withContext: AppContext.sharedInstance, success: loginSuccessObserver, error: loginErrorObserver, failure: loginFailureObserver, newPanda: newDeviceRegistrationObserver)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(_ sender: Any) {
        objects.insert(NSDate(), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! NSDate
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let object = objects[indexPath.row] as! NSDate
        cell.textLabel!.text = object.description
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


    func JSONStringify(value: Any, prettyPrinted: Bool = false) -> String{
        let options = prettyPrinted ? .prettyPrinted : JSONSerialization.WritingOptions(rawValue: 0)
        if JSONSerialization.isValidJSONObject(value) {
            do{
                let data = try JSONSerialization.data(withJSONObject: value, options: options)
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string as String
                }
            } catch {
                print("error")
            }
        }
        return ""
    }
}

