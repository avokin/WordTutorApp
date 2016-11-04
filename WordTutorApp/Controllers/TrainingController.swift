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

    fileprivate var currentIndex: Int = 0
    fileprivate var pendingIndex: Int?

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

        setViewControllers([controllers[0]], direction: UIPageViewControllerNavigationDirection.forward,
            animated: false, completion: nil)

        self.dataSource = self
    }


    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        let controller = pendingViewControllers.first! as! WordTrainingController
        pendingIndex = controller.wordIndex
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            currentIndex = pendingIndex!
        }
    }

    public func showNextController() {
        currentIndex += 1
        if currentIndex >= controllers.count {
            navigationController!.popViewController(animated: true)
        } else {
            setViewControllers([controllers[currentIndex]], direction: .forward, animated: true)
        }
    }

    fileprivate func getWordTrainingController() -> WordTrainingController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WordTrainingController") as! WordTrainingController
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.words.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let current = viewController as! WordTrainingController
        return current.leftSibling
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let current = viewController as! WordTrainingController
        return current.rightSibling;
    }
}
