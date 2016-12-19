import UIKit
class Report: NSObject
{
    var fruitAmount = 0
    var vegetableAmount = 0
    var proteinAmount = 0
    var dairyAmount = 0
    var grainsAmount = 0
    var oilsAmount = 0
    var user = ""
    var name = ""
    
    init(name:String, f:Int, v:Int, p:Int, d:Int, g:Int, o:Int, user: String)
    {
        fruitAmount = f
        vegetableAmount = v
        proteinAmount = p
        dairyAmount = d
        grainsAmount = g
        oilsAmount = o
        self.user = user
        self.name = name
    }
    
    func toAnyObject() -> Any
    {
        return [
            "name": name,
            "fruitAmount": fruitAmount,
            "vegetableAmount": vegetableAmount,
            "proteinAmount": proteinAmount,
            "dairyAmount": dairyAmount,
            "grainsAmount": grainsAmount,
            "oilsAmount": oilsAmount,
            "addedByUser": user
        ]
    }
}
