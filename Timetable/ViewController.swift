import UIKit

class CardsViewController: UIViewController {
    var dayTitle: String?
    let titleLabel = UILabel()
    var lessonsData: [[String: String]]?

    override func viewDidLoad() {
        // setup title
        super.viewDidLoad()
        titleLabel.text = dayTitle
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        // Set label constraints (optional, adjust as needed)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor) // Adjust the constant value as needed
        ])
        
        // Define card dimensions
        let cardWidth: CGFloat = 340
        let cardHeight: CGFloat = 70
        let cardSpacing: CGFloat = 5
        
        // Define lesson dictionary
        let lessons: [[String: String]] = [
            ["lesson": "Mathe", "startTime": "07:55", "endTime": "08:40", "color": "#61a8ec"],
            ["lesson": "Science", "startTime": "09:00", "endTime": "09:45"],
            ["lesson": "History", "startTime": "10:00", "endTime": "10:45"],
            ["lesson": "English", "startTime": "11:00", "endTime": "11:45"],
            ["lesson": "Art", "startTime": "12:00", "endTime": "12:45", "color": ""]
        ]
        
        // Calculate vertical center for first card
        var initialY: CGFloat = 120
        
        // Loop to create and position card views
        for lesson in lessons {
            let rect = CGRect(x: (view.frame.width - cardWidth) / 2, y: initialY, width: cardWidth, height: cardHeight)
            let newView = CardView(frame: rect)
            newView.mainView.backgroundColor = hexStringToUIColor(hex: lesson["color"] ?? "")
            newView.mainView.layer.cornerRadius = 10
            view.addSubview(newView)
            
            // Configure content for each card from the lesson dictionary
            newView.configureText(lessonName: lesson["lesson"] ?? "", timeBegin: lesson["startTime"] ?? "", timeEnd: lesson["endTime"] ?? "")
            
            // Update initial Y for next card
            initialY += cardHeight + cardSpacing
        }

    }
}

class ViewController: UIViewController, UIPageViewControllerDataSource {

    @IBOutlet weak var ContainerView: UIView!
    
    @IBOutlet weak var AddButton: UIButton!
    var pageViewController: UIPageViewController!
    let days: [String] = ["Monday", "Tuesday"]
    

    @IBAction func onAdd(_ sender: Any){
        print("bro")
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "CardCreation") as? NewCardView else { return }
        present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello world")
       
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.view.frame = ContainerView.frame
        
        let startingViewController = viewControllerAtIndex(0)!
        pageViewController.setViewControllers([startingViewController], direction: .forward, animated: false, completion: nil)
        pageViewController.view.bounds = ContainerView.bounds
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
    }
    
    func viewControllerAtIndex(_ index: Int) -> CardsViewController? {
        guard days.count > 0 else {
            return nil
        }
        let cardsViewController = CardsViewController()
        cardsViewController.dayTitle = days[index % days.count]
        return cardsViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let cardsViewController = viewController as? CardsViewController,
              let index = days.firstIndex(of: cardsViewController.dayTitle ?? "") else {
            return nil
        }
        let previousIndex = (index - 1 + days.count) % days.count
        return viewControllerAtIndex(previousIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let cardsViewController = viewController as? CardsViewController,
              let index = days.firstIndex(of: cardsViewController.dayTitle ?? "") else {
            return nil
        }
        let nextIndex = (index + 1) % days.count
        return viewControllerAtIndex(nextIndex)
    }

}

