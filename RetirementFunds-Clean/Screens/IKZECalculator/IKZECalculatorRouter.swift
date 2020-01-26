import UIKit

protocol IKZECalculatorRouterProtocol {
    func showRateOfReturnExplanation()
    func showEarlyExitPicker(earlyExitTax: IKZEEarlyExitTax?, consumer: IKZECalculatorEarlyExitConsumer)
}

protocol IKZECalculatorEarlyExitConsumer: AnyObject {
    func save(earlyExit: IKZEEarlyExitTax?)
}

final class IKZECalculatorRouter: IKZECalculatorRouterProtocol {
    
    private let rateOfReturnControllerProvider: () -> UIViewController
    private let earlyExitControllerProvider: (IKZEEarlyExitTax?, IKZECalculatorEarlyExitConsumer) -> UIViewController
    weak var sourceViewController: UIViewController?
    
    init(rateOfReturnControllerProvider: @escaping () -> UIViewController, earlyExitControllerProvider: @escaping (IKZEEarlyExitTax?, IKZECalculatorEarlyExitConsumer) -> UIViewController) {
        self.rateOfReturnControllerProvider = rateOfReturnControllerProvider
        self.earlyExitControllerProvider = earlyExitControllerProvider
    }
    
    func showRateOfReturnExplanation() {
        let controller = rateOfReturnControllerProvider()
        sourceViewController?.present(controller, animated: true, completion: nil)
    }
    
    func showEarlyExitPicker(earlyExitTax: IKZEEarlyExitTax?, consumer: IKZECalculatorEarlyExitConsumer) {
        let controller = earlyExitControllerProvider(earlyExitTax, consumer)
        sourceViewController?.present(controller, animated: true, completion: nil)
    }
    
}
