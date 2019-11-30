protocol OptionsListViewModelProtocol {
    var cellViewModels: [OptionsListCellViewModel] { get }
}

final class OptionsListViewModel: OptionsListViewModelProtocol {
    
    let cellViewModels = [
        OptionsListCellViewModel(title: "IKE", subtitle: "Indywidualne Konto Emerytalne"),
        OptionsListCellViewModel(title: "IKZE", subtitle: "Indywidualne Konto Zabepieczenia Emerytalnego"),
        OptionsListCellViewModel(title: "PPK", subtitle: "Pracownicze Plany Kapitałowe")
    ]
    
}
