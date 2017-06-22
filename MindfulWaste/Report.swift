import UIKit
class Report: NSObject
{
    var user = ""
    var name = ""
    var org = ""
    var date = ""
    
    var amount : [CGFloat] = [0,0,0,0,0]
    var number : [CGFloat] = [0]
    var detailFruitAmount : [CGFloat] = [0,0,0,0]
    var detailFruitNumber: [CGFloat] = [0,0,0,0]
    var detailVegetablesAmount : [CGFloat] = [0,0,0,0]
    var detailVegetablesNumber : [CGFloat] = [0,0,0,0]
    var detailDryGoodsAmount : [CGFloat] = [0,0,0,0,0,0,0,0,0]
    var detailDryGoodsNumber : [CGFloat] = [0,0,0,0,0,0,0,0,0]
    var detailDairyAmount : [CGFloat] = [0,0,0,0,0,0]
    var detailDairyNumber: [CGFloat] = [0,0,0,0,0,0]
    var detailMiscAmount : [CGFloat] = [0]
    var detailMiscNumber : [CGFloat] = [0]
    
    init(name:String, amount:[CGFloat], number:[CGFloat], f:[CGFloat], v:[CGFloat], dg:[CGFloat], d:[CGFloat], m:[CGFloat], fn:[CGFloat], vn:[CGFloat], dgn:[CGFloat], dn:[CGFloat], mn:[CGFloat], user: String, org: String)
    {
        self.user = user
        self.name = name
        
        self.detailFruitAmount = f
        self.detailVegetablesAmount = v
        self.detailDryGoodsAmount = dg
        self.detailDairyAmount = d
        self.detailMiscAmount = m
        self.detailFruitNumber = fn
        self.detailVegetablesNumber = vn
        self.detailDryGoodsNumber = dgn
        self.detailDairyNumber = dn
        self.detailMiscNumber = mn
        self.amount = amount
        self.number = number
        
        self.org = org
        let date2 = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        self.date = formatter.string(from: date2)
        
    }
    
    
    func toAnyObject() -> Any
    {
        return [
            "name": name,
            "addedByUser": user,
            "organization" : org,
            "date" : date,
            "fruitInformation" : [
                "fruitAmount" : amount[0],
                "fruitNumber" : number[0],
                "wholeFruit" : detailFruitAmount[0],
                "packagedFruit" : detailFruitAmount[1],
                "fruitJuice": detailFruitAmount[2],
                "otherFruit" : detailFruitAmount[3],
                "wholeFruitNumber" : detailFruitNumber[0],
                "packagedFruitNumber" : detailFruitNumber[1],
                "fruitJuiceNumber": detailFruitNumber[2],
                "otherFruitNumber" : detailFruitNumber[3]
            ],
            "vegetableInformation": [
                "vegetableAmount" : amount[1],
                "vegetableTotalNumber" : number[1],
                "vegetable" : detailVegetablesAmount[0],
                "packagedVegetables" : detailVegetablesAmount[1],
                "vegetableJuice" : detailVegetablesAmount[2],
                "otherVegetables" : detailVegetablesAmount[3],
                "vegetableNumber" : detailVegetablesNumber[0],
                "packagedVegetablesNumber" : detailVegetablesNumber[1],
                "vegetableJuiceNumber" : detailVegetablesNumber[2],
                "otherVegetablesNumber" : detailVegetablesNumber[3]
            ],
            "dryGoodsInformation" : [
                "dryGoodsAmount" : amount[2],
                "dryGoodsNumber" : number[2],
                "miscBaggedSnacks" : detailDryGoodsAmount[0],
                "fruitAndGrainBars" : detailDryGoodsAmount[1],
                "crackers" : detailDryGoodsAmount[2],
                "raisins" : detailDryGoodsAmount[3],
                "dryCereal" : detailDryGoodsAmount[4],
                "granola" : detailDryGoodsAmount[5],
                "muffins" : detailDryGoodsAmount[6],
                "chips" : detailDryGoodsAmount[7],
                "otherDryGoods" : detailDryGoodsAmount[8],
                "miscBaggedSnacksNumber" : detailDryGoodsNumber[0],
                "fruitAndGrainBarsNumber" : detailDryGoodsNumber[1],
                "crackersNumber" : detailDryGoodsNumber[2],
                "raisinsNumber" : detailDryGoodsNumber[3],
                "dryCerealNumber" : detailDryGoodsNumber[4],
                "granolaNumber" : detailDryGoodsNumber[5],
                "muffinsNumber" : detailDryGoodsNumber[6],
                "chipsNumber" : detailDryGoodsNumber[7],
                "otherDryGoodsNumber" : detailDryGoodsNumber[8]
            ],
            "dairyInformation" : [
                "dairyAmount" : amount[3],
                "dairyNumber" : number[3],
                "cheese" : detailDairyAmount[0],
                "yogurt" : detailDairyAmount[1],
                "whiteMilk" : detailDairyAmount[2],
                "chocolateMilk" : detailDairyAmount[3],
                "strawberryMilk" : detailDairyAmount[4],
                "otherDairy" : detailDairyAmount[5],
                "cheeseNumber" : detailDairyNumber[0],
                "yogurtNumber" : detailDairyNumber[1],
                "whiteMilkNumber" : detailDairyNumber[2],
                "chocolateMilkNumber" : detailDairyNumber[3],
                "strawberryMilkNumber" : detailDairyNumber[4],
                "otherDairyNumber" : detailDairyNumber[5]
            ],
            "miscInformation" : [
                "miscAmount" : amount[4],
                "miscNumber" : number[4]
            ]
        ]
        
        
    }
}
