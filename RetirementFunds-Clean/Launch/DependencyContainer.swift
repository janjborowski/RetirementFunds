import UIKit
import Swinject

final class DependencyContainer {
    
    private let container = Container()
    
    init() {}
    
    func createInitialController() -> UIViewController {
        let router = OptionsListRouter(ikeCalculatorProvider: ikeCalculatorProvider)
        let presenter = OptionsListPresenter()
        let interactor = OptionsListInteractor(router: router, presenter: presenter)
        let viewController = OptionsListViewController(interactor: interactor)
        let rootController = UINavigationController(rootViewController: viewController)
    
        presenter.viewController = viewController
        
        router.sourceViewController = rootController
        return rootController
    }
    
    func ikeCalculatorProvider() -> UIViewController {
        return IKECalculatorViewController()
    }
    
}
