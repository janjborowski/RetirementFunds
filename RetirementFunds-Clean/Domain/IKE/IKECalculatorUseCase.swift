import Foundation

protocol IKECalculatorUseCaseProtocol {
    func computeFutureCapital(for plan: IKESavingsPlan) -> IKEResult
}

final class IKECalculatorUseCase: IKECalculatorUseCaseProtocol {
    
    private let capitalGainsTax: Decimal = 0.19
    
    func computeFutureCapital(for plan: IKESavingsPlan) -> IKEResult {
        guard plan.yearsOfInvesting > 0 else {
            return .init(beforeTaxation: plan.annualSavings, afterTaxation: plan.annualSavings)
        }
        
        var totalCapital: Decimal = 0
        let investedCapital = Decimal(plan.yearsOfInvesting) * plan.annualSavings
        let capitalGrowth = 1 + plan.rateOfReturn / 100
        for _ in 0..<plan.yearsOfInvesting {
            totalCapital = (totalCapital + plan.annualSavings) * capitalGrowth
        }
        let afterTaxationCapital = investedCapital + (totalCapital - investedCapital) * (1 - capitalGainsTax)
        
        return IKEResult(beforeTaxation: totalCapital, afterTaxation: afterTaxationCapital)
    }
    
}
