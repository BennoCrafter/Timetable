import Foundation
import UIKit

class PageView: UIViewController {
    
    let titleLabel = UILabel()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBackground
        
        // Set up the title label
        setupTitleLabel()
    }
    
    func setupTitleLabel() {
        // Configure the title label
        titleLabel.text = "Day Title" // Placeholder text, can be dynamic
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.textAlignment = .center
        
        // Add the label to the view
        view.addSubview(titleLabel)
        
        // Set label constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }
}
