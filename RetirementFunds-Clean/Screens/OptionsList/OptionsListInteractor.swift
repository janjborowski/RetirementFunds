protocol OptionsListInteractorProtocol {
    func requestContent()
    func goToCalculator(with option: RetirementPlanOption)
}

enum RetirementPlanOption {
    case ike
    case ikze
    case ppk
}

final class OptionsListInteractor: OptionsListInteractorProtocol {
    
    private let router: OptionsListRouterProtocol
    private let presenter: OptionsListPresenterProtocol
    
    init(router: OptionsListRouterProtocol, presenter: OptionsListPresenterProtocol) {
        self.router = router
        self.presenter = presenter
    }
    
    func requestContent() {
        presenter.showCells(options: [.ike, .ikze, .ppk])
    }
    
    func goToCalculator(with option: RetirementPlanOption) {
        switch option {
        case .ike:
            router.goToIKE()
        default:
            break
        }
    }
    
}
