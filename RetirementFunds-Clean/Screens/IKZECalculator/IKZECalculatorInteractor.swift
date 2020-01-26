import Foundation

protocol IKZECalculatorInteractorProtocol {
    func setUp()
    func showRateOfReturnExplanation()
    func showEarlyExitPicker()
    func update(annualInput: Int?)
    func update(yearsToRetire: Int?)
    func update(rateOfReturn: Int?)
    func update(taxBracketIndex: Int?)
}

final class IKZECalculatorInteractor: IKZECalculatorInteractorProtocol {
    
    private let presenter: IKZECalculatorPresenterProtocol
    private let router: IKZECalculatorRouterProtocol
    private let ikzeCalculator: IKZECalculatorUseCaseProtocol
    private let maximumIKZELimit = 6272
    
    private let constants: FinancialConstants
    
    private var annualInput: Int?
    private var yearsToRetire: Int?
    private var taxBracket: Decimal?
    private var rateOfReturn: Int
    private var earlyExitTax: IKZEEarlyExitTax?
    
    init(router: IKZECalculatorRouterProtocol, presenter: IKZECalculatorPresenterProtocol, ikzeCalculator: IKZECalculatorUseCaseProtocol, constants: FinancialConstants) {
        self.router = router
        self.presenter = presenter
        self.rateOfReturn = constants.basicRateOfReturn
        self.constants = constants
        self.ikzeCalculator = ikzeCalculator
    }
    
    func setUp() {
        presenter.setUpPresenting(rateOfReturn: rateOfReturn, taxBrackets: constants.taxBrackets)
    }
    
    func showRateOfReturnExplanation() {
        router.showRateOfReturnExplanation()
    }
    
    func showEarlyExitPicker() {
        router.showEarlyExitPicker(earlyExitTax: earlyExitTax, consumer: self)
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
    
    func update(taxBracketIndex: Int?) {
        guard let index = taxBracketIndex else {
            return
        }
        self.taxBracket = constants.taxBrackets[index].value
        recalculateIfPossible()
    }
    
    private func recalculateIfPossible() {
        guard let annualInput = annualInput,
            let yearsToRetire = yearsToRetire,
            let taxBracket = taxBracket else {
                return
        }
        
        let plan = IKZESavingsPlan(
            annualSavings: annualInput,
            yearsToRetire: yearsToRetire,
            rateOfReturn: rateOfReturn,
            taxBracket: taxBracket,
            earlyExit: earlyExitTax
        )
        let result = ikzeCalculator.computeFutureCapital(for: plan)
        presenter.show(futureCapital: result.capital, taxReturn: result.taxReturn)
    }
    
}

extension IKZECalculatorInteractor: IKZECalculatorEarlyExitConsumer {
    
    func save(earlyExit: IKZEEarlyExitTax?) {
        self.earlyExitTax = earlyExit
        recalculateIfPossible()
        presenter.show(earlyExitTax: earlyExitTax)
    }
    
}
