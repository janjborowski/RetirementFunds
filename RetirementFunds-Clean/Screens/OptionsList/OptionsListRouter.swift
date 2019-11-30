import UIKit

protocol OptionsListRouterProtocol {
    func goToIKE()
}

final class OptionsListRouter: OptionsListRouterProtocol {
    
    private let ikeCalculatorProvider: () -> UIViewController
    weak var sourceViewController: UINavigationController?
    
    init(ikeCalculatorProvider: @escaping () -> UIViewController) {
        self.ikeCalculatorProvider = ikeCalculatorProvider
    }
    
    func goToIKE() {
        let viewController = ikeCalculatorProvider()
        sourceViewController?.pushViewController(viewController, animated: true)
    }
    
}
