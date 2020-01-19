import Foundation

struct IKZESavingsPlan {
    
    enum EarlyExitTax {
        case progressiveRate(basicRate: Decimal, basicRateLimit: Decimal, excessRate: Decimal, yearToDateIncome: Decimal)
        case flatRate(Decimal)
    }
    
    let annualSavings: Int
    let yearsToRetire: Int
    let rateOfReturn: Int
    let taxBracket: Decimal
 
    let earlyExit: EarlyExitTax?
    
}
