import Foundation

struct IKZESavingsPlan {
    
    let annualSavings: Decimal
    let yearsOfInvesting: Int
    let rateOfReturn: Decimal
    let taxBracket: Decimal

    let taxReturnReinvestment: Bool
    let earlyExit: IKZEEarlyExitTax?
    
}

enum IKZEEarlyExitTax {
    case progressiveRate(basicRate: Decimal, basicRateLimit: Decimal, excessRate: Decimal, yearToDateIncome: Decimal)
    case flatRate(Decimal)
}
