import Foundation
import UIKit

class PageView: UIViewController {
    
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBackground
        
        // Set up the title label
        setupTitleLabel()
    }
    
    // MARK
    // todo
    func setupTitleLabel() {
        // Configure the title label
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.textAlignment = .center
        
        // Add the label to the view
        view.addSubview(titleLabel)
        
        // Set label constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        ])
        
        dateLabel.font = UIFont.boldSystemFont(ofSize: 10)
        dateLabel.textAlignment = .center
        
        // Add the label to the view
        view.addSubview(dateLabel)
        
        // Set label constraints
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        ])
    }
}
