protocol IKECalculatorInteractorProtocol {
    func showRateOfReturnExplanation()
    func update(annualInput: Int?)
    func update(yearsToRetirement: Int?)
}

final class IKECalculatorInteractor: IKECalculatorInteractorProtocol {
    
    private let router: IKECalculatorRouterProtocol
    private let presenter: IKECalculatorPresenterProtocol
    private let ikeCalculator: IKECalculatorUseCaseProtocol
    
    private var annualInput: Int?
    private var yearsToRetirement: Int?
    
    init(router: IKECalculatorRouterProtocol, presenter: IKECalculatorPresenterProtocol, ikeCalculator: IKECalculatorUseCaseProtocol) {
        self.router = router
        self.presenter = presenter
        self.ikeCalculator = ikeCalculator
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
    
    private func recalculateIfPossible() {
        guard let annualInput = annualInput,
            let yearsToRetirement = yearsToRetirement else {
                return
        }
        let plan = RetirementPlan(annualSavingsAmount: annualInput, yearsToRetire: yearsToRetirement)
        let futureCapital = ikeCalculator.computeFutureCapital(for: plan)
        presenter.show(futureCapital: futureCapital.beforeTaxation)
    }
    
}
