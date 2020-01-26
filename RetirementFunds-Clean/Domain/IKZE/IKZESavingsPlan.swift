import Foundation

struct IKZESavingsPlan {
    
    let annualSavings: Int
    let yearsToRetire: Int
    let rateOfReturn: Int
    let taxBracket: Decimal
 
    let earlyExit: IKZEEarlyExitTax?
    
}

enum IKZEEarlyExitTax {
    case progressiveRate(basicRate: Decimal, basicRateLimit: Decimal, excessRate: Decimal, yearToDateIncome: Decimal)
    case flatRate(Decimal)
}
