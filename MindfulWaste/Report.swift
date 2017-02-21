import UIKit
class Report: NSObject
{
    var user = ""
    var name = ""
    
    var amount : [CGFloat] = [0,0,0,0,0]
    var detailFruitAmount : [CGFloat] = [0,0,0,0]
    var detailVegetablesAmount : [CGFloat] = [0,0,0,0]
    var detailDryGoodsAmount : [CGFloat] = [0,0,0,0,0,0,0,0,0]
    var detailDairyAmount : [CGFloat] = [0,0,0,0,0,0]
    var detailMiscAmount : [CGFloat] = [0]
    
    init(name:String, amount:[CGFloat], f:[CGFloat], v:[CGFloat], dg:[CGFloat], d:[CGFloat], m:[CGFloat], user: String)
    {
        self.user = user
        self.name = name
        
        self.detailFruitAmount = f
        self.detailVegetablesAmount = v
        self.detailDryGoodsAmount = dg
        self.detailDairyAmount = d
        self.detailMiscAmount = m
        self.amount = amount
        
    }
    
    
    func toAnyObject() -> Any
    {
        return [
            "name": name,
            "addedByUser": user,
            "fruitInformation" : [
                "fruitAmount" : amount[0],
                "wholeFruit" : detailFruitAmount[0],
                "packagedFruit" : detailFruitAmount[1],
                "fruitJuice": detailFruitAmount[2],
                "otherFruit" : detailFruitAmount[3]
            ],
            "vegetableInformation": [
                "vegetableAmount" : amount[1],
                "vegetable" : detailVegetablesAmount[0],
                "packagedVegetables" : detailVegetablesAmount[1],
                "vegetableJuice" : detailVegetablesAmount[2],
                "otherVegetables" : detailVegetablesAmount[3]
            ],
            "dryGoodsInformation" : [
                "dryGoodsAmount" : amount[2],
                "miscBaggedSnacks" : detailDryGoodsAmount[0],
                "fruitAndGrainBars" : detailDryGoodsAmount[1],
                "crackers" : detailDryGoodsAmount[2],
                "raisins" : detailDryGoodsAmount[3],
                "dryCereal" : detailDryGoodsAmount[4],
                "granola" : detailDryGoodsAmount[5],
                "muffins" : detailDryGoodsAmount[6],
                "chips" : detailDryGoodsAmount[7],
                "otherDryGoods" : detailDryGoodsAmount[8]
            ],
            "dairyInformation" : [
                "dairyAmount" : amount[3],
                "cheese" : detailDairyAmount[0],
                "yogurt" : detailDairyAmount[1],
                "whiteMilk" : detailDairyAmount[2],
                "chocolateMilk" : detailDairyAmount[3],
                "strawberryMilk" : detailDairyAmount[4],
                "otherDairy" : detailDairyAmount[5]
            ],
            "miscInformation" : [
                "miscAmount" : amount[4]
            ]
        ]
        
        
    }
}
