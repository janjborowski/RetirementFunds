import Foundation

extension String {
    
    private var mainLanguage: String {
        return "pl"
    }
    
    var localized: String {
        let localizedString = NSLocalizedString(self, comment: "")
        guard localizedString == self else {
            return localizedString
        }
        
        guard let pathForMainBundle = Bundle.main.path(forResource: mainLanguage, ofType: "lproj") else {
            return localizedString
        }
        let bundle = Bundle(path: pathForMainBundle)
        return bundle?.localizedString(forKey: self, value: nil, table: nil) ?? localizedString
    }
    
}
