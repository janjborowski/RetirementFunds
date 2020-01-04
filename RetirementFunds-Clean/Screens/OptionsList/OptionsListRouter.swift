import UIKit

protocol OptionsListRouterProtocol {
    func goToIKE()
    func goToIKZE()
}

final class OptionsListRouter: OptionsListRouterProtocol {
    
    private let ikeCalculatorProvider: () -> UIViewController
    private let ikzeCalculatorProvider: () -> UIViewController
    weak var sourceViewController: UINavigationController?
    
    init(ikeCalculatorProvider: @escaping () -> UIViewController, ikzeCalculatorProvider: @escaping () -> UIViewController) {
        self.ikeCalculatorProvider = ikeCalculatorProvider
        self.ikzeCalculatorProvider = ikzeCalculatorProvider
    }
    
    func goToIKE() {
        let viewController = ikeCalculatorProvider()
        sourceViewController?.pushViewController(viewController, animated: true)
    }
    
    func goToIKZE() {
        let viewController = ikzeCalculatorProvider()
        sourceViewController?.pushViewController(viewController, animated: true)
    }
    
}
