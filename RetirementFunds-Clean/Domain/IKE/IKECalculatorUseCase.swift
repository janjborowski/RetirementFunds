import Foundation

protocol IKECalculatorUseCaseProtocol {
    func computeFutureCapital(for plan: IKESavingsPlan) -> IKEResult
}

final class IKECalculatorUseCase: IKECalculatorUseCaseProtocol {
    
    private let capitalGainsTax: Decimal = 0.19
    
    func computeFutureCapital(for plan: IKESavingsPlan) -> IKEResult {
        let annualSavings = Decimal(plan.annualSavingsAmount)
        let rateOfReturn = 1 + Decimal(plan.rateOfReturn) / 100
        
        guard plan.yearsToRetire > 0 else {
            return .init(noGainsCapital: plan.annualSavingsAmount)
        }
        
        var totalCapital: Decimal = 0
        let investedCapital = Decimal(plan.yearsToRetire * plan.annualSavingsAmount)
        for _ in 0..<plan.yearsToRetire {
            totalCapital = (totalCapital + annualSavings) * rateOfReturn
        }
        let afterTaxationCapital = investedCapital + (totalCapital - investedCapital) * (1 - capitalGainsTax)
        
        return IKEResult(beforeTaxation: totalCapital, afterTaxation: afterTaxationCapital)
    }
    
}
