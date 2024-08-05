import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {

    var pages = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting the dataSource to self
        self.dataSource = self

        // Loading the view controllers frµom the storyboard and adding a view to each
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyboard.instantiateViewController(withIdentifier: "vc1")
        let vc2 = storyboard.instantiateViewController(withIdentifier: "vc2")
        let vc3 = storyboard.instantiateViewController(withIdentifier: "vc3")

        // Adding a view to each view controller
        addContent(to: vc1, withText: "Page 1")
        addContent(to: vc2, withText: "Page 2")
        addContent(to: vc3, withText: "Page 3")

        // Adding the view controllers to the pages array
        pages.append(vc1)
        pages.append(vc2)
        pages.append(vc3)

        // Setting the initial view controller to display
        setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
    }

    // MARK: - Helper Method

    private func addContent(to viewController: UIViewController, withText text: String) {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false

        viewController.view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor)
        ])
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
