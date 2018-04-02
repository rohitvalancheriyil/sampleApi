//
//  ViewController.swift
//  RohitCoredata_JsonParsing_Swift
//
//  Created by Rohit Kr on 02/04/18.
//  Copyright © 2018 Rohit Kr. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view, typically from a nib.
        let service = APIService()
        service.getDataWith { (result) in
            switch result {
            case .Success(let data):
                self.clearData()
                self.saveInCoreDataWith(array: data)
            case .Error(let message):
                DispatchQueue.main.async {
                    self.showAlertWith(title: "Error", message: message)
                }
            }
        }
    }


    @IBAction func noveToSecondVC(_ sender: Any) {
        let viewController: ViewController2? = storyboard?.instantiateViewController(withIdentifier: "ViewController2") as? ViewController2
        navigationController?.pushViewController(viewController!, animated: true)
    }
    
    func showAlertWith(title: String, message: String, style: UIAlertControllerStyle = .alert) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: title, style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func saveInCoreDataWith(array: [String: AnyObject]) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let person = NSEntityDescription.insertNewObject(forEntityName: "SampleEntity",
                                                         into: context)
        person.setValue(array, forKey: "responseArray")
        do {
            try context.save()
        } catch let error {
            print(error)
        }    }
    

    
 private   func clearData() {
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let context = delegate.persistentContainer.viewContext
    let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "SampleEntity")
    let request = NSBatchDeleteRequest(fetchRequest: fetch)
    do {
        try context.execute(request)
        try context.save()
    } catch {
        print ("There was an error")
    }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

