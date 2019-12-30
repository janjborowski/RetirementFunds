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
    
    private var annualInput: Int?
    private var yearsToRetirement: Int?
    private var rateOfReturn: Int?
    private var earlyExit: Bool = false
    
    init(router: IKECalculatorRouterProtocol, presenter: IKECalculatorPresenterProtocol, ikeCalculator: IKECalculatorUseCaseProtocol) {
        self.router = router
        self.presenter = presenter
        self.ikeCalculator = ikeCalculator
    }
    
    func setUp() {
        presenter.setUpPresenting()
    }
    
    func showRateOfReturnExplanation() {
        router.showRateOfReturnExplanation()
    }
    
    func update(annualInput: Int?) {
        self.annualInput = annualInput
        recalculateIfPossible()
    }
    
    func update(yearsToRetirement: Int?) {
        self.yearsToRetirement = yearsToRetirement
        recalculateIfPossible()
    }
    
    func update(rateOfReturn: Int?) {
        self.rateOfReturn = rateOfReturn
        recalculateIfPossible()
    }
    
    func update(earlyExit: Bool?) {
        self.earlyExit = earlyExit ?? false
        recalculateIfPossible()
    }
    
    private func recalculateIfPossible() {
        guard let annualInput = annualInput,
            let yearsToRetirement = yearsToRetirement,
            let rateOfReturn = rateOfReturn else {
                return
        }
        let plan = RetirementPlan(annualSavingsAmount: annualInput, yearsToRetire: yearsToRetirement, rateOfReturn: rateOfReturn)
        let futureCapital = ikeCalculator.computeFutureCapital(for: plan)
        
        let displayedResult = earlyExit ? futureCapital.afterTaxation : futureCapital.beforeTaxation
        presenter.show(futureCapital: displayedResult)
    }
    
}
