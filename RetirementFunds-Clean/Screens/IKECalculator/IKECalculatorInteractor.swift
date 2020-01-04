protocol IKECalculatorInteractorProtocol {
    func setUp()
    func showRateOfReturnExplanation()
    func update(annualInput: Int?)
    func update(yearsToRetirement: Int?)
    func update(rateOfReturn: Int?)
    func update(earlyExit: Bool?)
}

final class IKECalculatorInteractor: IKECalculatorInteractorProtocol {
    
    private let router: IKECalculatorRouterProtocol
    private let presenter: IKECalculatorPresenterProtocol
    private let ikeCalculator: IKECalculatorUseCaseProtocol
    
    private let maximumIKELimit = 15681
    
    private var annualInput: Int?
    private var yearsToRetirement: Int?
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
    
    func update(yearsToRetirement: Int?) {
        self.yearsToRetirement = yearsToRetirement
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
            let yearsToRetirement = yearsToRetirement else {
                return
        }
        let plan = RetirementPlan(annualSavingsAmount: annualInput, yearsToRetire: yearsToRetirement, rateOfReturn: rateOfReturn)
        let futureCapital = ikeCalculator.computeFutureCapital(for: plan)
        
        let displayedResult = earlyExit ? futureCapital.afterTaxation : futureCapital.beforeTaxation
        presenter.show(futureCapital: displayedResult)
    }
    
}
