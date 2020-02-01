import Foundation

struct IKEResult {
    
    let beforeTaxation: Int
    let afterTaxation: Int
    
    init(beforeTaxation: Decimal, afterTaxation: Decimal) {
        self.beforeTaxation = Int((beforeTaxation as NSDecimalNumber).doubleValue)
        self.afterTaxation = Int((afterTaxation as NSDecimalNumber).doubleValue)
    }
    
}
