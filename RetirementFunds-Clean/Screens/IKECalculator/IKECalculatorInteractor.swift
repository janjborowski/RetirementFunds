import Foundation

protocol IKECalculatorInteractorProtocol {
    func setUp()
    func showRateOfReturnExplanation()
    func update(annualInput: Int?)
    func update(yearsOfInvesting: Int?)
    func update(rateOfReturn: Int?)
    func update(earlyExit: Bool?)
}

final class IKECalculatorInteractor: IKECalculatorInteractorProtocol {
    
    private let router: IKECalculatorRouterProtocol
    private let presenter: IKECalculatorPresenterProtocol
    private let ikeCalculator: IKECalculatorUseCaseProtocol
    
    private let maximumIKELimit = 15681
    
    private var annualInput: Int?
    private var yearsOfInvesting: Int?
    private var rateOfReturn: Int
    private var earlyExit: Bool = false
    
    init(router: IKECalculatorRouterProtocol, presenter: IKECalculatorPresenterProtocol, ikeCalculator: IKECalculatorUseCaseProtocol, basicRateOfReturn: Int) {
        self.router = router
        self.presenter = presenter
        self.ikeCalculator = ikeCalculator
        self.rateOfReturn = basicRateOfReturn
    }
    
    func setUp() {
        presenter.setUpPresenting(rateOfReturn: rateOfReturn)
    }
    
    func showRateOfReturnExplanation() {
        router.showRateOfReturnExplanation()
    }
    
    func update(annualInput: Int?) {
        guard let annualInput = annualInput else {
            return
        }
        
        if annualInput <= maximumIKELimit {
            self.annualInput = annualInput
            recalculateIfPossible()
            presenter.showValidAnnualInput()
        } else {
            presenter.showInvalidAnnualInput(limit: maximumIKELimit)
        }
    }
    
    func update(yearsOfInvesting: Int?) {
        self.yearsOfInvesting = yearsOfInvesting
        recalculateIfPossible()
    }
    
    func update(rateOfReturn: Int?) {
        guard let rateOfReturn = rateOfReturn else {
            return
        }
        
        self.rateOfReturn = rateOfReturn
        recalculateIfPossible()
    }
    
    func update(earlyExit: Bool?) {
        self.earlyExit = earlyExit ?? false
        recalculateIfPossible()
    }
    
    private func recalculateIfPossible() {
        guard let annualInput = annualInput,
            let yearsOfInvesting = yearsOfInvesting else {
                return
        }
        let plan = IKESavingsPlan(
            annualSavings: Decimal(annualInput),
            yearsOfInvesting: yearsOfInvesting,
            rateOfReturn: Decimal(rateOfReturn)
        )
        let futureCapital = ikeCalculator.computeFutureCapital(for: plan)
        
        let displayedResult = earlyExit ? futureCapital.afterTaxation : futureCapital.beforeTaxation
        presenter.show(futureCapital: displayedResult)
    }
    
}
