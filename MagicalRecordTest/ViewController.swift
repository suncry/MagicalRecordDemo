//
//  ViewController.swift
//  MagicalRecordTest
//
//  Created by heyunpeng on 16/3/29.
//  Copyright © 2016年 heyunpeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addDataClicked() {
        
        let detail = DetailEntiry.MR_createEntity()! as DetailEntiry
        detail.name = "test"
        
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait();
    }
    
    @IBAction func findDataClicked() {
        
        let detailArry = DetailEntiry.MR_findAllSortedBy("name", ascending: true)!
        for item in detailArry {
            if let detail = item as? DetailEntiry {
                print("all data", detail.name)
            }
        }
        
        let anyArry = DetailEntiry.MR_findByAttribute("name", withValue: "test")!
        for item in anyArry {
            if let detail = item as? DetailEntiry {
                print("find by name", detail.name)
            }
        }
        
        let filter = NSPredicate(format:"name='test'")
        let request = DetailEntiry.MR_requestAllWithPredicate(filter)
        let someArry = DetailEntiry.MR_executeFetchRequest(request)!
        
        for item in someArry {
            if let detail = item as? DetailEntiry {
                print("find by predicate", detail.name)
            }
        }
        
        let detail = DetailEntiry.MR_findFirst()
        
        if let item = detail {
            print("frist item is", item.name)
        }
    }

    @IBAction func updateDataClicked() {
        
        let detail = DetailEntiry.MR_findFirst()
        
        if let item = detail {
            item.name = "test1"
        }
        
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait();
        
        MagicalRecord.saveWithBlock({ (localContext) -> Void in
            
            let localDetail = detail?.MR_inContext(localContext)
            if let item = localDetail {
                item.name = "syn"
            }
            }, completion: { (success, error) -> Void in
                
                //This completion block is called on the main thread (queue), so this is also safe for triggering UI updates.
                print("update is", success)
        })
    }
    
    @IBAction func delDataClicked() {
        
        let detail = DetailEntiry.MR_findFirst()
        if let item = detail {
            item.MR_deleteEntity()
        }
        
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
    }
}

