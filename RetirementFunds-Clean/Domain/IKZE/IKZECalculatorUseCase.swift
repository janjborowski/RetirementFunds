import Foundation

protocol IKZECalculatorUseCaseProtocol {
    func computeFutureCapital(for plan: IKZESavingsPlan) -> IKZEResult
}

final class IKZECalculatorUseCase: IKZECalculatorUseCaseProtocol {
    
    private let financialConstants: FinancialConstants
    
    init(financialConstants: FinancialConstants) {
        self.financialConstants = financialConstants
    }
    
    func computeFutureCapital(for plan: IKZESavingsPlan) -> IKZEResult {
        guard plan.yearsToRetire > 0 else {
            return .init(capital: plan.annualSavings, taxReturn: 0)
        }
        
        var totalCapital: Decimal = 0
        let taxReturn: Decimal = plan.annualSavings * plan.taxBracket * Decimal(plan.yearsToRetire)
        let capitalGrowth = 1 + plan.rateOfReturn / 100
        
        for _ in 0..<plan.yearsToRetire {
            totalCapital = (totalCapital + plan.annualSavings) * capitalGrowth
        }
        
        let finalCapital = computeExitCapital(capital: totalCapital, earlyExit: plan.earlyExit)
        return IKZEResult(
            capital: finalCapital,
            taxReturn: taxReturn
        )
    }
    
    private func computeExitCapital(capital: Decimal, earlyExit: IKZEEarlyExitTax?) -> Decimal {
        guard let earlyExit = earlyExit else {
            return capital * (1 - financialConstants.flatRateIncomeTax)
        }
        
        return computeEarlyExitCapital(capital: capital, earlyExit: earlyExit)
    }
    
    private func computeEarlyExitCapital(capital: Decimal, earlyExit: IKZEEarlyExitTax) -> Decimal {
        switch earlyExit {
        case .flatRate(let flatRate):
            return capital * (1 - flatRate)
        case .progressiveRate(basicRate: let basicRate, basicRateLimit: let basicRateLimit, excessRate: let excessRate, yearToDateIncome: let income):
            let totalYearToDateIncome = capital + income
            if totalYearToDateIncome <= basicRateLimit {
                return capital * (1 - basicRate)
            } else {
                if income < basicRateLimit {
                    let excess = totalYearToDateIncome - basicRateLimit
                    let upToLimitCapital = capital - excess
                    return upToLimitCapital * (1 - basicRate) + excess * (1 - excessRate)
                } else {
                    return capital * (1 - excessRate)
                }
            }
        }
    }
    
}
