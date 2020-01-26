import Foundation

protocol IKZEEarlyExitInteractorProtocol {
    
    func setUp()
    func update(isEarlyExit: Bool?)
    func pickEarlyExitOption(index: Int?)
    
    func update(yearToDateIncome: Int?)
    
    func cancel()
    func saveAndExit()
    
}

final class IKZEEarlyExitInteractor: IKZEEarlyExitInteractorProtocol {
    
    private let constants: FinancialConstants
    private let presenter: IKZEEarlyExitPresenterProtocol
    private let router: IKZEEarlyExitRouterProtocol
    
    private let options = IKZESavingsPlan.EarlyExitTax.dummyOptions
    
    private var earlyExitTax: IKZESavingsPlan.EarlyExitTax?
    
    init(presenter: IKZEEarlyExitPresenterProtocol, router: IKZEEarlyExitRouterProtocol, financialConstants: FinancialConstants, earlyExitTax: IKZESavingsPlan.EarlyExitTax?) {
        self.presenter = presenter
        self.router = router
        self.constants = financialConstants
        self.earlyExitTax = earlyExitTax
    }
    
    func setUp() {
        presenter.set(options: options)
        presenter.show(earlyExit: earlyExitTax)
    }
    
    func update(isEarlyExit: Bool?) {
        if isEarlyExit == true {
            presenter.showOptions()
        } else {
            presenter.hideOptions()
            earlyExitTax = nil
        }
    }
    
    func pickEarlyExitOption(index: Int?) {
        guard let index = index else {
            earlyExitTax = nil
            return
        }
        
        if index == 0 {
            earlyExitTax = .flatRate(0.19)
        } else {
            earlyExitTax = .progressiveRate(basicRate: 0.17, basicRateLimit: 85000, excessRate: 0.32, yearToDateIncome: 0)
        }
        presenter.show(earlyExit: earlyExitTax)
    }
    
    func update(yearToDateIncome: Int?) {
        guard let earlyExitTax = earlyExitTax,
            let yearToDateIncome = yearToDateIncome else {
            return
        }
        if case IKZESavingsPlan.EarlyExitTax.progressiveRate(basicRate: let basicRate, basicRateLimit: let limit, excessRate: let excessRate, yearToDateIncome: _) = earlyExitTax {
            self.earlyExitTax = .progressiveRate(
                basicRate: basicRate,
                basicRateLimit: limit,
                excessRate: excessRate,
                yearToDateIncome: Decimal(yearToDateIncome)
            )
        }
    }
    
    func cancel() {
        router.cancel()
    }
    
    func saveAndExit() {
        router.save(earlyExitTax: earlyExitTax)
    }
    
}

private extension IKZESavingsPlan.EarlyExitTax {
    
    static var dummyOptions: [IKZESavingsPlan.EarlyExitTax] {
        return [
            .flatRate(0),
            .progressiveRate(basicRate: 0, basicRateLimit: 0, excessRate: 0, yearToDateIncome: 0)
        ]
    }
    
}
