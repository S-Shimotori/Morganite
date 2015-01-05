//
//  ViewController.swift
//  MorganiteModel
//
//  Created by Shigure Shimotori on 1/3/15.
//  Copyright (c) 2015 Shigure Shimotori. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        var insertData = Dictionary<String,AnyObject>()
        var results = [NSManagedObject]()
        
        println("Morganiteにエンティティを与えます")
        var mt = Morganite(table: "Model")
        println("初期化しますね")
        mt.delete()
        
        println("hogeと200を与えてみます")
        insertData["someDataA"] = "hoge"
        insertData["someDataB"] = 200
        mt.insert(insertData)
        println("fooと100を与えてみます")
        insertData["someDataA"] = "foo"
        insertData["someDataB"] = 100
        mt.insert(insertData)
        println("barと400を与えてみます")
        insertData["someDataA"] = "bar"
        insertData["someDataB"] = 400
        mt.insert(insertData)
        
        println("200以上を取得してみましょう")
        results = mt.select(format: NSPredicate(format:"%K >= %d","someDataB",200))
        for result in results{
            println("\((result as Model).someDataA) \((result as Model).someDataB)")
        }
        
        println("400を-400にかえてみます")
        var updateData = Dictionary<String,AnyObject>()
        updateData["someDataB"] = -400
        mt.update(updateData,format:NSPredicate(format:"%K = %d","someDataB",400))
        
        println("ほっほっほ。")
        updateData.removeAll()
        updateData["someDataA"] = "hohoho"
        mt.update(updateData)
        
        println("全部取得してみましょう")
        results = mt.select()
        for result in results{
            println("\((result as Model).someDataA) \((result as Model).someDataB)")
        }
        
        println("-400をけします")
        mt.delete(format: NSPredicate(format:"%K = %d","someDataB",-400))
        
        println("全部取得してみましょう")
        results = mt.select()
        for result in results{
            println("\((result as Model).someDataA) \((result as Model).someDataB)")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

