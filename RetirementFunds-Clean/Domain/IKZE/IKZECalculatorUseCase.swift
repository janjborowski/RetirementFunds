import Foundation

protocol IKZECalculatorUseCaseProtocol {
    func computeFutureCapital(for plan: IKZESavingsPlan) -> IKZEResult
}

final class IKZECalculatorUseCase: IKZECalculatorUseCaseProtocol {
    
    func computeFutureCapital(for plan: IKZESavingsPlan) -> IKZEResult {
        let annualSavings = Decimal(plan.annualSavings)
        
        guard plan.yearsToRetire > 0 else {
            return .init(noGainsCapital: plan.annualSavings)
        }
        
        var totalCapital: Decimal = 0
        let taxReturn: Decimal = annualSavings * plan.taxBracket * Decimal(plan.yearsToRetire)
        let capitalGrowth = 1 + Decimal(plan.rateOfReturn) / 100
        
        for _ in 0..<plan.yearsToRetire {
            totalCapital = (totalCapital + annualSavings) * capitalGrowth
        }
        
        return IKZEResult(capital: totalCapital, taxReturn: taxReturn)
    }
    
}
