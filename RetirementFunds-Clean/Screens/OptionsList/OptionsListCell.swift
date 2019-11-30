import UIKit

final class OptionsListCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return "\(self)"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: OptionsListCell.reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(style: .subtitle, reuseIdentifier: OptionsListCell.reuseIdentifier)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .systemBackground
        accessoryType = .disclosureIndicator
    }
    
    func configure(with viewModel: OptionsListCellViewModel) {
        textLabel?.text = viewModel.title
        detailTextLabel?.text = viewModel.subtitle
    }
    
}
