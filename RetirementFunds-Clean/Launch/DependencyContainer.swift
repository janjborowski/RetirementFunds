import UIKit
import Swinject

final class DependencyContainer {
    
    private let container = Container()
    
    init() {
        registerViewModels()
        registerViewControllers()
    }
    
    private func registerViewModels() {
        container.register(OptionsListViewModelProtocol.self) { (resolver) -> OptionsListViewModelProtocol in
            return OptionsListViewModel()
        }
    }
    
    private func registerViewControllers() {
        container.register(OptionsListViewController.self) { (resolver) -> OptionsListViewController in
            let viewModel = resolver.resolve(OptionsListViewModelProtocol.self)!
            return OptionsListViewController(viewModel: viewModel)
        }
    }
    
    func createInitialController() -> UIViewController {
        let viewController = container.resolve(OptionsListViewController.self)!
        return UINavigationController(rootViewController: viewController)
    }
    
}
