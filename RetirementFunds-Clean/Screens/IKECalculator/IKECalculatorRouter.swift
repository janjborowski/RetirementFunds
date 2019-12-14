import UIKit

protocol IKECalculatorRouterProtocol {
    func showRateOfReturnExplanation()
}

final class IKECalculatorRouter: IKECalculatorRouterProtocol {
    
    private let rateOfReturnControllerProvider: () -> UIViewController
    weak var sourceViewController: UIViewController?
    
    init(rateOfReturnControllerProvider: @escaping () -> UIViewController) {
        self.rateOfReturnControllerProvider = rateOfReturnControllerProvider
    }
    
    func showRateOfReturnExplanation() {
        let controller = rateOfReturnControllerProvider()
        sourceViewController?.present(controller, animated: true, completion: nil)
    }
    
}
