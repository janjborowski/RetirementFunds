import UIKit

final class RateOfReturnExplanationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addExplanation()
        setUpSelf()
        addBackButton()
    }
    
    private func addExplanation() {
        let label = UILabel()
        label.text = "rate_of_return_explanation".localized
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            label.bottomAnchor.constraint(lessThanOrEqualTo: view.layoutMarginsGuide.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    private func setUpSelf() {
        view.backgroundColor = UIColor.systemBackground
        title = "rate_of_return".localized
    }
    
    private func addBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeScreen))
    }
    
    @objc private func closeScreen() {
        dismiss(animated: true, completion: nil)
    }

}
