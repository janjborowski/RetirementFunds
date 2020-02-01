import Foundation

protocol IKZECalculatorInteractorProtocol {
    func setUp()
    func showRateOfReturnExplanation()
    func showEarlyExitPicker()
    func update(annualInput: Int?)
    func update(yearsOfInvesting: Int?)
    func update(rateOfReturn: Int?)
    func update(taxBracketIndex: Int?)
    func update(taxReturnReinvestment: Bool?)
}

final class IKZECalculatorInteractor: IKZECalculatorInteractorProtocol {
    
    private let presenter: IKZECalculatorPresenterProtocol
    private let router: IKZECalculatorRouterProtocol
    private let ikzeCalculator: IKZECalculatorUseCaseProtocol
    private let maximumIKZELimit = 6272
    
    private let constants: FinancialConstants
    
    private var annualInput: Int?
    private var yearsOfInvesting: Int?
    private var taxBracket: Decimal?
    private var rateOfReturn: Int
    private var taxReturnReinvestment = false
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
    
    func update(taxBracketIndex: Int?) {
        guard let index = taxBracketIndex else {
            return
        }
        self.taxBracket = constants.taxBrackets[index].value
        recalculateIfPossible()
    }
    
    func update(taxReturnReinvestment: Bool?) {
        guard let taxReturnReinvestment = taxReturnReinvestment else {
            return
        }
        self.taxReturnReinvestment = taxReturnReinvestment
        recalculateIfPossible()
    }
    
    private func recalculateIfPossible() {
        guard let annualInput = annualInput,
            let yearsOfInvesting = yearsOfInvesting else {
                presenter.show(investedCapital: 0)
                return
        }
        
        presenter.show(investedCapital: annualInput * yearsOfInvesting)
        guard let taxBracket = taxBracket else {
            return
        }
        
        let plan = IKZESavingsPlan(
            annualSavings: Decimal(annualInput),
            yearsOfInvesting: yearsOfInvesting,
            rateOfReturn: Decimal(rateOfReturn),
            taxBracket: taxBracket,
            taxReturnReinvestment: taxReturnReinvestment,
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
