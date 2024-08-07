import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {

    var pages = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting the dataSource to self
        self.dataSource = self

        // Loading the view controllers from the storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyboard.instantiateViewController(withIdentifier: "vc1")
        let vc2 = storyboard.instantiateViewController(withIdentifier: "vc2")
        let vc3 = storyboard.instantiateViewController(withIdentifier: "vc3")

        // Adding content to each view controller
        addContent(to: vc1, withText: "Page 1")
        addContent(to: vc2, withText: "Page 2")
        addContent(to: vc3, withText: "Page 3")

        // Adding the view controllers to the pages array
        pages = [vc1, vc2, vc3]

        // Setting the initial view controller to display
        setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
    }

    // MARK: - Helper Method

    private func addContent(to viewController: UIViewController, withText text: String) {
        let cardWidth: CGFloat = UIScreen.main.bounds.width - 30
        let cardHeight: CGFloat = 70
        let initialY: CGFloat = 100
        
        let cardView = CardView(frame: CGRect(x: (view.frame.width - cardWidth) / 2, y: initialY, width: cardWidth, height: cardHeight))
        cardView.configureText(lessonName: text, timeBegin: "Start Time", timeEnd: "End Time")
        cardView.delegate = self // Set the delegate if needed

        viewController.view.addSubview(cardView)
    }

    // MARK: - UIPageViewControllerDataSource Methods

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        let previousIndex = (currentIndex - 1 + pages.count) % pages.count
        return pages[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        let nextIndex = (currentIndex + 1) % pages.count
        return pages[nextIndex]
    }
}

// MARK: - CardViewDelegate

extension PageViewController: CardViewDelegate {
    func cardViewDidTap(_ cardView: CardView) {
        print("Card tapped: \(cardView)")
    }
}
