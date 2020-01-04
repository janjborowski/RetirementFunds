protocol IKZECalculatorInteractorProtocol {
    func setUp()
    func showRateOfReturnExplanation()
    func update(annualInput: Int?)
    func update(yearsToRetirement: Int?)
    func update(rateOfReturn: Int?)
}

final class IKZECalculatorInteractor: IKZECalculatorInteractorProtocol {
    
    private let presenter: IKZECalculatorPresenterProtocol
    private let router: IKZECalculatorRouterProtocol
    private let maximumIKZELimit = 6272
    
    private var annualInput: Int?
    private var yearsToRetirement: Int?
    private var rateOfReturn: Int
    
    init(router: IKZECalculatorRouterProtocol, presenter: IKZECalculatorPresenterProtocol, basicRateOfReturn: Int) {
        self.router = router
        self.presenter = presenter
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
        
        if annualInput <= maximumIKZELimit {
            self.annualInput = annualInput
            recalculateIfPossible()
            presenter.showValidAnnualInput()
        } else {
            presenter.showInvalidAnnualInput(limit: maximumIKZELimit)
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
    
    private func recalculateIfPossible() {}
    
}
