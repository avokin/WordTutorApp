//
// Created by Andrey Vokin on 14/10/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

class TrainingController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var training: Training?
    var groupNumber = 0
    var directMode = true

    var words = [Word]()
    var controllers = [WordTrainingController]()

    public var currentIndex = 0
    private var successCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        successCount = 0
        words = training!.getGroup(groupNumber)
        shuffle()

        for i in 0..<words.count {
            let controller = getWordTrainingController()
            let word = words[i]
            controller.wordIndex = i
            controller.word = word
            controller.directMode = directMode
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

    public func showNextController(success: Bool) {
        if success {
            successCount += 1
        }
        currentIndex += 1
        if currentIndex >= controllers.count {
            DataProvider.getInstance().syncUpdatedWords(withImport: false)
            navigationController!.popViewController(animated: true)

            let alert = UIAlertController(title: "", message: "\(successCount) correct answers from \(words.count) questions", preferredStyle: .alert)
            navigationController!.topViewController!.present(alert, animated: true, completion: nil)

            let when = DispatchTime.now() + 3
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
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

    private func shuffle() {
        if words.count < 2 {
            return
        }

        for i in 0..<words.count - 1 {
            let j = Int(arc4random_uniform(UInt32(words.count - i))) + i
            guard i != j else { continue }
            swap(&words[i], &words[j])
        }
    }
}
