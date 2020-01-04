import UIKit

protocol IKZECalculatorRouterProtocol {
    func showRateOfReturnExplanation()
}

final class IKZECalculatorRouter: IKZECalculatorRouterProtocol {
    
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
