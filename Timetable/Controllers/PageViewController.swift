import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIGestureRecognizerDelegate {

    var pages = [UIViewController]()
    // card settings
    let cardWidth: CGFloat = Config.UI.cardWidth
    let cardHeight: CGFloat = Config.UI.cardHeight
    let cardSpacing: CGFloat = Config.UI.cardSpacing
    let startingYPosition: CGFloat = Config.UI.startingYPosition
    var timetableManager: TimetableManager
    
    // todo make better
    let days = Day.allCases
    
    init(timetableManager: TimetableManager) {
        self.timetableManager = timetableManager
        
        // Call the superclass initializer
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
         
    }

    // Required initializer (for using with storyboards, but needed here as well)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

 
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hm", days)
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

    private func addEntryToPage(to viewController: UIViewController, withEntry entry: Entry, cardCount: Int) {
        // Calculate the y position by properly accounting for spacing and height
        let yOffset = startingYPosition + CGFloat(cardCount) * (cardHeight + cardSpacing)
        
        // Create the card view with the correct frame
        let cardView = CardView(frame: CGRect(x: (view.frame.width - cardWidth) / 2, y: yOffset, width: cardWidth, height: cardHeight))
        
        cardView.configure(entry: entry)
        cardView.mainView.layer.cornerRadius = Config.UI.cardCornerRadius
        //cardView.delegate = self

        viewController.view.addSubview(cardView)
    }

    
    private func setupPages(count: Int) {
        for i in 0..<count {
            let pageView = PageView()
            let dayName = days[i].rawValue
            if Config.UI.firstLetterOfTitleUpper{
                pageView.titleLabel.text = dayName.prefix(1).uppercased() + dayName.dropFirst()
            }else{
                pageView.titleLabel.text = dayName

            }
    
                
            pages.append(pageView)
            loadPageContent(pageViewController: pageView, day: days[i])
        }
    }
    
    private func loadPageContent(pageViewController: UIViewController, day: Day) {
        let loadedEntries = timetableManager.getEntries(forDay: day)
        print(loadedEntries)
        for (index, entry) in loadedEntries.enumerated() {
            addEntryToPage(to: pageViewController, withEntry: entry, cardCount: index)
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

//extension PageViewController: CardViewDelegate {
    //func cardViewDidTap(_ cardView: CardView) {
    //    print("Card tapped: \(cardView)")
    //}
//}
