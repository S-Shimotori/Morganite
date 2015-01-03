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
    private var table:String = ""
    
    public func insert(columns:[AnyObject])->Bool{
        if let managedObjectContext = appDelegate.managedObjectContext{
            var managedObject = NSEntityDescription.insertNewObjectForEntityForName(table,inManagedObjectContext:managedObjectContext) as NSManagedObject
            insertCore(&managedObject,columns:columns)
            appDelegate.saveContext()
            return true
        }else{
            return false
        }
    }
    private func insertCore(inout managedObject:NSManagedObject,columns:[AnyObject]){
        fatalError("")
    }

    public func select(format:NSPredicate)->[NSManagedObject]{
        var results = [NSManagedObject]()
        if let managedObjectContext = appDelegate.managedObjectContext{
            let fetchRequest = NSFetchRequest()
            fetchRequest.entity = NSEntityDescription.entityForName(table,inManagedObjectContext:managedObjectContext)
            fetchRequest.predicate = format
            var error: NSError? = nil;
            
            if var records = managedObjectContext.executeFetchRequest(fetchRequest,error:&error){
                for managedObject in results {
                    results.append(managedObject)
                }
            }
        }
        return results
    }
    
    public func update(columns:[AnyObject],format:NSPredicate)->Bool{
        if let managedObjectContext = appDelegate.managedObjectContext{
            let fetchRequest = NSFetchRequest();
            fetchRequest.entity = NSEntityDescription.entityForName(table, inManagedObjectContext: managedObjectContext);
            fetchRequest.predicate = format
            var error: NSError? = nil;

            if var results = managedObjectContext.executeFetchRequest(fetchRequest,error:&error){
                updateCore(&results,columns:columns)
            }else{
                return false
            }
            appDelegate.saveContext()
            return true
        }else{
            return false
        }
    }
    private func updateCore(inout managedObjects:[AnyObject],columns:[AnyObject]){
        fatalError("")
    }
    
    func delete(format:NSPredicate)->Bool{
        if let managedObjectContext = appDelegate.managedObjectContext{
            let fetchRequest = NSFetchRequest();
            fetchRequest.entity = NSEntityDescription.entityForName(table,inManagedObjectContext:managedObjectContext)
            fetchRequest.predicate = format
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