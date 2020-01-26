import Foundation

protocol IKZEEarlyExitPresenterProtocol {
    func showOptions()
    func hideOptions()
    func set(options: [IKZEEarlyExitTax])
    func show(earlyExit: IKZEEarlyExitTax?)
}

final class IKZEEarlyExitPresenter: IKZEEarlyExitPresenterProtocol {
    
    weak var controller: IKZEEarlyExitViewControllerProtocol?
    
    func showOptions() {
        controller?.showOptions()
    }
    
    func hideOptions() {
        controller?.hideOptions()
    }
    
    func set(options: [IKZEEarlyExitTax]) {
        let texts = options.map(mapToText)
        controller?.set(options: texts)
    }
    
    func show(earlyExit: IKZEEarlyExitTax?) {
        guard let earlyExit = earlyExit else {
            controller?.showNoEarlyExit()
            return
        }
        
        let option = mapToText(earlyExit)
        switch earlyExit {
        case .flatRate:
            controller?.showFlatRateExitTax(option: option)
        case .progressiveRate(basicRate: _, basicRateLimit: _, excessRate: _, yearToDateIncome: let income):
            controller?.showProgressiveRate(option: option, income: income.intValue)
        }
    }
    
    private func mapToText(_ earlyExitTax: IKZEEarlyExitTax) -> String {
        switch earlyExitTax {
        case .flatRate:
            return "flat_tax".localized
        case .progressiveRate:
            return "progressive_tax_rate".localized
        }
    }
    
}
