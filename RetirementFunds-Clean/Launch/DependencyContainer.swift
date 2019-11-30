import UIKit
import Swinject

final class DependencyContainer {
    
    private let container = Container()
    
    init() {}
    
    func createInitialController() -> UIViewController {
        let router = OptionsListRouter(ikeCalculatorProvider: ikeCalculatorProvider)
        let viewModel = OptionsListViewModel(router: router)
        let viewController = OptionsListViewController(viewModel: viewModel)
        let rootController = UINavigationController(rootViewController: viewController)
    
        router.sourceViewController = rootController
        return rootController
    }
    
    func ikeCalculatorProvider() -> UIViewController {
        return IKECalculatorViewController()
    }
    
}
