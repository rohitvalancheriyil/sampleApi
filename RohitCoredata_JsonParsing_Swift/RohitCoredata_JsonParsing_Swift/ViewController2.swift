//
//  ViewController2.swift
//  RohitCoredata_JsonParsing_Swift
//
//  Created by Rohit Kr on 02/04/18.
//  Copyright © 2018 Rohit Kr. All rights reserved.
//

import UIKit
import CoreData
class ViewController2: UIViewController {

    @IBOutlet var weatherId: UILabel!
    @IBOutlet var weatherDesc: UILabel!
    @IBOutlet var weatherName: UILabel!
    var mainDic : [String:AnyObject] = [:]
    var weather : [[String:AnyObject]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.fetchAndPrintEachPerson()
        // Do any additional setup after loading the view.
    }

    func fetchAndPrintEachPerson() {
        let fetchRequest = NSFetchRequest<SampleEntity>(entityName: "SampleEntity")
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        do {
            let fetchedResults = try context.fetch(fetchRequest)
            for item in fetchedResults {
                print(item.value(forKey: "responseArray")!)
                mainDic = item.value(forKey: "responseArray")! as! [String : AnyObject]
                weather = mainDic["weather"] as! [[String : AnyObject]]
                weatherId.text = mainDic["base"] as? String
                weatherDesc.text = weather[0]["description"] as? String
                weatherName.text = weather[0]["main"] as? String

            }
        } catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
