    import UIKit

    struct PageInfo {
        let view: PageView
        let date: String
    }

    class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIGestureRecognizerDelegate {
        
        private var pages: [PageInfo] = []
        private var loadedPageIndices: Set<Int> = []
        private var currentDateIndex: Int?
        private var dateRange = ("2024-09-08", "2025-12-24")
        private let pageInfoDateFormatter = DateFormatter()
        private let preloadRange = 3 // Number of pages to preload before and after the current page
        private var timetableManager: TimetableManager
        
        init(timetableManager: TimetableManager) {
            self.timetableManager = timetableManager
            super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.dataSource = self
            self.pageInfoDateFormatter.dateFormat = "yyyy-MM-dd"
            let d = Date().timeIntervalSince1970
            setupPages(startDate: self.pageInfoDateFormatter.date(from: dateRange.0)!, endDate: self.pageInfoDateFormatter.date(from: dateRange.1)!)
            print(Date().timeIntervalSince1970 - d)
            
            // Find today's page and set it as the initial page
            let todayDate: String = self.pageInfoDateFormatter.string(from: Date())
            guard let todayIndex = pages.firstIndex(where: { $0.date == todayDate }) else {
                print("No view controller found for today's date.")
                return
            }
            currentDateIndex = todayIndex
            
            // Preload pages around today
            preloadPages(around: todayIndex)
            
            // Set the initial view controller
            setViewControllers([pages[todayIndex].view], direction: .forward, animated: true, completion: nil)
            
            
            for gestureRecognizer in self.gestureRecognizers {
                gestureRecognizer.delegate = self
            }
        }
        
        private func setupPages(startDate: Date, endDate: Date) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .none
            dateFormatter.timeZone = TimeZone.current
            
            for (day, date) in generateDayNames(from: startDate, to: endDate) {
                let pageView = PageView()
                if Config.UI.firstLetterOfTitleUpper {
                    pageView.titleLabel.text = day.prefix(1).uppercased() + day.dropFirst()
                } else {
                    pageView.titleLabel.text = day
                }
                pageView.dateLabel.text = dateFormatter.string(from: date)
                pages.append(PageInfo(view: pageView, date: self.pageInfoDateFormatter.string(from: date)))
            }
        }
        
        private func preloadPages(around index: Int) {
            let start = max(0, index - preloadRange)
            let end = min(pages.count - 1, index + preloadRange)
            for i in start...end where !loadedPageIndices.contains(i) {
                loadPageContent(at: i)
                print(i)
            }
        }
        
        private func loadPageContent(at index: Int) {
            let pageInfo = pages[index]
            let date = pageInfoDateFormatter.date(from: pageInfo.date)!
            let loadedEvents = timetableManager.getEvents(from: date, to: date)
            for (i, event) in loadedEvents.enumerated() {
                addEventToPage(to: pageInfo.view, withEvent: event, cardCount: i)
            }
            loadedPageIndices.insert(index)
        }

        private func addEventToPage(to viewController: UIViewController, withEvent event: Event, cardCount: Int) {
            let yOffset = Config.UI.startingYPosition + CGFloat(cardCount) * (Config.UI.cardHeight + Config.UI.cardSpacing)
            let cardView = CardView(frame: CGRect(x: (view.frame.width - Config.UI.cardWidth) / 2, y: yOffset, width: Config.UI.cardWidth, height: Config.UI.cardHeight))
            cardView.configure(event: event)
            cardView.mainView.layer.cornerRadius = Config.UI.cardCornerRadius
            viewController.view.addSubview(cardView)
        }
        
        // MARK: - UIPageViewControllerDataSource Methods

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let currentIndex = pages.firstIndex(where: { $0.view == viewController }) else { return nil }
            let previousIndex = (currentIndex - 1 + pages.count) % pages.count
            preloadPages(around: previousIndex)
            return pages[previousIndex].view
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let currentIndex = pages.firstIndex(where: { $0.view == viewController }) else { return nil }
            let nextIndex = (currentIndex + 1) % pages.count
            preloadPages(around: nextIndex)
            return pages[nextIndex].view
        }
        
        // MARK: - UIGestureRecognizerDelegate

        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
    }
