protocol OptionsListViewModelProtocol {
    var cellViewModels: [OptionsListCellViewModel] { get }
    
    func goToCalculator(at index: Int)
}

final class OptionsListViewModel: OptionsListViewModelProtocol {
    
    private let router: OptionsListRouterProtocol
    
    let cellViewModels = [
        OptionsListCellViewModel(title: "IKE", subtitle: "Indywidualne Konto Emerytalne"),
        OptionsListCellViewModel(title: "IKZE", subtitle: "Indywidualne Konto Zabepieczenia Emerytalnego"),
        OptionsListCellViewModel(title: "PPK", subtitle: "Pracownicze Plany Kapitałowe")
    ]
    
    init(router: OptionsListRouterProtocol) {
        self.router = router
    }
    
    func goToCalculator(at index: Int) {
        switch index {
        case 0:
            router.goToIKE()
        default:
            break
        }
    }
    
}
