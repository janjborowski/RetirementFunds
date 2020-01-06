protocol IKZECalculatorInteractorProtocol {
    func setUp()
    func showRateOfReturnExplanation()
    func update(annualInput: Int?)
    func update(yearsToRetire: Int?)
    func update(rateOfReturn: Int?)
}

final class IKZECalculatorInteractor: IKZECalculatorInteractorProtocol {
    
    private let presenter: IKZECalculatorPresenterProtocol
    private let router: IKZECalculatorRouterProtocol
    private let ikzeCalculator: IKZECalculatorUseCaseProtocol
    private let maximumIKZELimit = 6272
    
    private var annualInput: Int?
    private var yearsToRetire: Int?
    private var rateOfReturn: Int
    
    init(router: IKZECalculatorRouterProtocol, presenter: IKZECalculatorPresenterProtocol, ikzeCalculator: IKZECalculatorUseCaseProtocol, basicRateOfReturn: Int) {
        self.router = router
        self.presenter = presenter
        self.rateOfReturn = basicRateOfReturn
        self.ikzeCalculator = ikzeCalculator
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
        
        if annualInput <= maximumIKZELimit {
            self.annualInput = annualInput
            recalculateIfPossible()
            presenter.showValidAnnualInput()
        } else {
            presenter.showInvalidAnnualInput(limit: maximumIKZELimit)
        }
    }
    
    func update(yearsToRetire: Int?) {
        self.yearsToRetire = yearsToRetire
        recalculateIfPossible()
    }
    
    func update(rateOfReturn: Int?) {
        guard let rateOfReturn = rateOfReturn else {
            return
        }
        self.rateOfReturn = rateOfReturn
        recalculateIfPossible()
    }
    
    private func recalculateIfPossible() {
        guard let annualInput = annualInput,
            let yearsToRetire = yearsToRetire else {
                return
        }
        
        let savings = IKZERetirementSavings(annualSavings: annualInput, yearsToRetire: yearsToRetire, rateOfReturn: rateOfReturn, taxBracket: 0.18)
        let result = ikzeCalculator.computeFutureCapital(for: savings)
        presenter.show(futureCapital: result.capital, taxReturn: result.taxReturn)
    }
    
}
