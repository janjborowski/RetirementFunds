import Foundation

struct IKZEResult {
    
    let capital: Int
    let taxReturn: Int
    
    init(capital: Decimal, taxReturn: Decimal) {
        self.capital = Int((capital as NSDecimalNumber).doubleValue)
        self.taxReturn = Int((taxReturn as NSDecimalNumber).doubleValue)
    }
    
    init(noGainsCapital: Int) {
        self.capital = noGainsCapital
        self.taxReturn = 0
    }
    
}
