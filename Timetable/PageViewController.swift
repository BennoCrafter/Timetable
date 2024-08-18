import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIGestureRecognizerDelegate {

    var pages = [UIViewController]()
    let dataManager = DataManager()
    let save_example_data: Bool = true
    var mondayLessons: [Lesson] = []
    
    // card settings
    let cardWidth: CGFloat = Config.UI.cardWidth
    let cardHeight: CGFloat = Config.UI.cardHeight
    let cardSpacing: CGFloat = Config.UI.cardSpacing
    let startingYPosition: CGFloat = Config.UI.startingYPosition
    let days: [String] = ["monday", "tuesday", "wednesday", "thursday", "friday"]

    override func viewDidLoad() {
        super.viewDidLoad()

        if (save_example_data) {
            let sampleLesson = Lesson(name: "Math", color: "", timeBegin: "07:55", timeEnd: "08:30", events: [])
            dataManager.saveLessons(forDay: "monday", lessons: [sampleLesson])
            let sampleLesson2 = Lesson(name: "Science", color: "", timeBegin: "08:40", timeEnd: "09:55", events: [])
            dataManager.saveLessons(forDay: "monday", lessons: [sampleLesson, sampleLesson2])
            dataManager.saveLessons(forDay: "wednesday", lessons: [sampleLesson2])
        }

        // Setting the dataSource to self
        self.dataSource = self

        // Setup the pages
        setupPages(count: 5)
        
        // Setting the initial view controller to display
        setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
        
        // Allowing swipe gestures across the entire screen
        for gestureRecognizer in self.gestureRecognizers {
            gestureRecognizer.delegate = self
        }
    }

    // MARK: - Helper Method

    private func addLessonToPage(to viewController: UIViewController, withLesson lesson: Lesson, cardCount: Int) {
        // Calculate the y position by properly accounting for spacing and height
        let yOffset = startingYPosition + CGFloat(cardCount) * (cardHeight + cardSpacing)
        
        // Create the card view with the correct frame
        let cardView = CardView(frame: CGRect(x: (view.frame.width - cardWidth) / 2, y: yOffset, width: cardWidth, height: cardHeight))
        
        cardView.configureText(lesson: lesson)
        cardView.mainView.layer.cornerRadius = Config.UI.cardCornerRadius
        cardView.delegate = self

        viewController.view.addSubview(cardView)
    }

    
    private func setupPages(count: Int) {
        for i in 0..<count {
            let pageView = PageView()
            pageView.titleLabel.text = days[i]
            pages.append(pageView)
            loadPageContent(pageViewController: pageView, day: days[i])
        }
    }
    
    private func loadPageContent(pageViewController: UIViewController, day: String) {
        if let loadedLessons = dataManager.loadLessons(forDay: day) {
            for (index, lesson) in loadedLessons.enumerated() {
                addLessonToPage(to: pageViewController, withLesson: lesson, cardCount: index)
                // You can now use `index` if needed for additional logic
            }
        } else {
            print("No lessons found for \(day).")
        }
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
    
    // MARK: - UIGestureRecognizerDelegate

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

// MARK: - CardViewDelegate

extension PageViewController: CardViewDelegate {
    func cardViewDidTap(_ cardView: CardView) {
        print("Card tapped: \(cardView)")
    }
}
