import Foundation

struct RetirementPlan {
    
    let annualSavingsAmount: Int
    let yearsToRetire: Int
    let rateOfReturn: Int
    
}

struct InvestmentResult {
    
    let beforeTaxation: Int
    let afterTaxation: Int
    
    init(beforeTaxation: Decimal, afterTaxation: Decimal) {
        self.beforeTaxation = Int((beforeTaxation as NSDecimalNumber).doubleValue)
        self.afterTaxation = Int((afterTaxation as NSDecimalNumber).doubleValue)
    }
    
    init(noGainsCapital: Int) {
        beforeTaxation = noGainsCapital
        afterTaxation = noGainsCapital
    }
    
}

protocol IKECalculatorUseCaseProtocol {
    func computeFutureCapital(for plan: RetirementPlan) -> InvestmentResult
}

final class IKECalculatorUseCase: IKECalculatorUseCaseProtocol {
    
    private let capitalGainsTax: Decimal = 0.19
    
    func computeFutureCapital(for plan: RetirementPlan) -> InvestmentResult {
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
        
        return InvestmentResult(beforeTaxation: totalCapital, afterTaxation: afterTaxationCapital)
    }
    
}
