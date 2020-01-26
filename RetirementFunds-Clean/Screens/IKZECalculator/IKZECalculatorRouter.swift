import UIKit

protocol IKZECalculatorRouterProtocol {
    func showRateOfReturnExplanation()
    func showEarlyExitPicker(earlyExitTax: IKZESavingsPlan.EarlyExitTax?, consumer: IKZECalculatorEarlyExitConsumer)
}

protocol IKZECalculatorEarlyExitConsumer: AnyObject {
    func save(earlyExit: IKZESavingsPlan.EarlyExitTax?)
}

final class IKZECalculatorRouter: IKZECalculatorRouterProtocol {
    
    private let rateOfReturnControllerProvider: () -> UIViewController
    private let earlyExitControllerProvider: (IKZESavingsPlan.EarlyExitTax?, IKZECalculatorEarlyExitConsumer) -> UIViewController
    weak var sourceViewController: UIViewController?
    
    init(rateOfReturnControllerProvider: @escaping () -> UIViewController, earlyExitControllerProvider: @escaping (IKZESavingsPlan.EarlyExitTax?, IKZECalculatorEarlyExitConsumer) -> UIViewController) {
        self.rateOfReturnControllerProvider = rateOfReturnControllerProvider
        self.earlyExitControllerProvider = earlyExitControllerProvider
    }
    
    func showRateOfReturnExplanation() {
        let controller = rateOfReturnControllerProvider()
        sourceViewController?.present(controller, animated: true, completion: nil)
    }
    
    func showEarlyExitPicker(earlyExitTax: IKZESavingsPlan.EarlyExitTax?, consumer: IKZECalculatorEarlyExitConsumer) {
        let controller = earlyExitControllerProvider(earlyExitTax, consumer)
        sourceViewController?.present(controller, animated: true, completion: nil)
    }
    
}
