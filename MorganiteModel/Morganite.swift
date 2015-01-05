//
//  Morganite.swift
//  MorganiteModel
//
//  Created by Shigure Shimotori on 1/3/15.
//  Copyright (c) 2015 Shigure Shimotori. All rights reserved.
//

import UIKit
import CoreData

public class Morganite{
    private var appDelegate:AppDelegate{
        get{return UIApplication.sharedApplication().delegate as AppDelegate}
    }
    private var table:String
    
    init(table:String){
        self.table = table
    }
    
    
    public func insert(columns:Dictionary<String,AnyObject>)->Bool{
        if let managedObjectContext = appDelegate.managedObjectContext{
            var managedObject = NSEntityDescription.insertNewObjectForEntityForName(table,inManagedObjectContext:managedObjectContext) as NSManagedObject
            managedObject.setValuesForKeysWithDictionary(columns)
            appDelegate.saveContext()
            return true
        }else{
            return false
        }
    }

    public func select(format:NSPredicate?=nil)->[NSManagedObject]{
        var results = [NSManagedObject]()
        if let managedObjectContext = appDelegate.managedObjectContext{
            let fetchRequest = NSFetchRequest()
            fetchRequest.entity = NSEntityDescription.entityForName(table,inManagedObjectContext:managedObjectContext)
            if format != nil{
                fetchRequest.predicate = format
            }
            var error: NSError? = nil;
            
            if var records = managedObjectContext.executeFetchRequest(fetchRequest,error:&error){
                for record in records {
                    results.append(record as NSManagedObject)
                }
            }
        }
        return results
    }
    
    public func update(columns:Dictionary<String,AnyObject>,format:NSPredicate?=nil)->Bool{
        if let managedObjectContext = appDelegate.managedObjectContext{
            let fetchRequest = NSFetchRequest();
            fetchRequest.entity = NSEntityDescription.entityForName(table, inManagedObjectContext: managedObjectContext)
            if format != nil{
                fetchRequest.predicate = format
            }
            var error: NSError? = nil;

            if var results = managedObjectContext.executeFetchRequest(fetchRequest,error:&error){
                for result in results{
                    result.setValuesForKeysWithDictionary(columns)
                }
            }else{
                return false
            }
            appDelegate.saveContext()
            return true
        }else{
            return false
        }
    }
    
    func delete(format:NSPredicate? = nil)->Bool{
        if let managedObjectContext = appDelegate.managedObjectContext{
            let fetchRequest = NSFetchRequest();
            fetchRequest.entity = NSEntityDescription.entityForName(table,inManagedObjectContext:managedObjectContext)
            if format != nil{
                fetchRequest.predicate = format
            }
            var error: NSError? = nil;
            
            if var results = managedObjectContext.executeFetchRequest(fetchRequest,error: &error) {
                for managedObject in results {
                    let model = managedObject as NSManagedObject
                    managedObjectContext.deleteObject(model)
                }
            }else{
                return false
            }
            appDelegate.saveContext()
            return true
        }else{
            return false
        }
    }
}