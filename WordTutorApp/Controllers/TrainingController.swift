//
// Created by Andrey Vokin on 14/10/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

class TrainingController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var training: Training?
    var groupNumber = 0
    var words = [Word]()
    var controllers = [WordTrainingController]()

    private var currentIndex: Int = 0
    private var pendingIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        words = training!.getGroup(groupNumber)

        for i in 0..<words.count {
            let controller = getWordTrainingController()
            let word = words[i]
            controller.wordIndex = i
            controller.word = word
            if i > 0 {
                controller.leftSibling = controllers[i - 1]
                controllers[i - 1].rightSibling = controller
            }
            controllers.append(controller)
        }

        if words.count > 1 {
            controllers[0].leftSibling = controllers[words.count - 1]
            controllers[words.count - 1].rightSibling = controllers[0]
        }

        setViewControllers([controllers[0]], direction: UIPageViewControllerNavigationDirection.Forward,
            animated: false, completion: nil)

        self.dataSource = self
    }


    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        let controller = pendingViewControllers.first! as! WordTrainingController
        pendingIndex = controller.wordIndex
    }

    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            currentIndex = pendingIndex!
        }
    }

    private func getWordTrainingController() -> WordTrainingController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("WordTrainingController") as! WordTrainingController
    }

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.words.count
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }

    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let current = viewController as! WordTrainingController
        return current.leftSibling
    }

    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let current = viewController as! WordTrainingController
        return current.rightSibling;
    }
}
