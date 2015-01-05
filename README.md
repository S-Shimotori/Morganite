#Morganite

##コンセプト
CoreDataを簡単に扱いたかった(過去形)

##使い方
1.CoreDataを使える状態にします  
AppDelegateとかxcdatamodeldとかNSManagedObjectのサブクラスの用意  
  
2.このプロジェクトに含まれているMorganiteクラスをそのへんに置きます  
Morganite.swift以外はただのゴミみたいなもんです  
一応ViewControllerくらいは使用例として見る価値が…ないです  
  
3.使いたいときにMorganiteを連れてきてエンティティ名を与えます  
```swift
    var hoge = Morganite("Hoge")  
```
  
4.データを入れてみます  
辞書に属性と入れるものをセットにしてそいつをぶっこみます  
```swift
    var insertData = Dictionary<String,AnyObject>()  
    insertData["dataA"] = "hoge"  
    insertData["dataB"] = 200  
    hoge.insert(insertData)  
```
これで入ってるといいですね  
  
5.データを持ってきてみましょう  
```swift
    var results = [NSManagedObject]()  
    results = hoge.select()  
    for result in results{  
        println("\(result.dataA) \(result.dataB)")  
    }  
    results = hoge.select(format: NSPredicate(format:"%K >= %d","dataB",100))  
    for result in results{  
        println("\(result.dataA) \(result.dataB)")  
    }  
```
うまくいけば何か取れているでしょう  
  
6.データを改ざんしてみましょう  
```swift
    var updateData = Dictionary<String,AnyObject>()  
    updateData["dataB"] = -400  
    hoge.update(updateData,format:NSPredicate(format:"%K = %d","dataB",400))  
```
  
7.あっ!せっかく改ざんしたのに消しちゃった!  
```swift
    hoge.delete(format: NSPredicate(format:"%K = %d","dataB",-400))  
    hoge.delete()  
```
後はがんばってください。  
