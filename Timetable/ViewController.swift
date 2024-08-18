import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the PageViewController
        let pageViewController = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        
        pageViewController.view.frame = view.bounds.offsetBy(dx: 0, dy: 110)
        // Notify the PageViewController that it has been moved to a parent
        pageViewController.didMove(toParent: self)
    }
    
    @IBAction func onAdd(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "AddLessonView") as? AddLessonView else { return }
        present(vc, animated: true)
    }
    
}
