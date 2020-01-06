import Foundation

struct FinancialConstants {
    
    let basicRateOfReturn: Int
    let capitalGainsTax: Decimal
    
    static var `default`: FinancialConstants {
        return FinancialConstants(
            basicRateOfReturn: 4,
            capitalGainsTax: 0.19
        )
    }
    
}
