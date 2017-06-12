//
//  IntroductionViewController.swift
//  VOLA
//
//  Created by Connie Nguyen on 6/10/17.
//  Copyright © 2017 Systers-Opensource. All rights reserved.
//

import UIKit

class IntroductionNavigationController: UINavigationController {}

class IntroductionViewController: UIViewController {

    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!

    private var viewDidLayout: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment for testing purposes
        Defaults.setObject(forKey: .shownIntro, object: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if !viewDidLayout {
            viewDidLayout = true
            loadScrollView()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.isNavigationBarHidden = false
    }

    private func loadScrollView() {
        scrollView.delegate = self
        let pageCount = Intro.introSlides.count
        scrollView.loadScrollPages(pageCount: 3, subviewType: IntroSlideView.self)

        // Configure data on pages
        var i: Int = 0
        for case let page as IntroSlideView in scrollView.subviews {
            guard i < pageCount else {
                Logger.error("Attempted to configure scroll view page out of index.")
                return
            }
            // TODO: ERROR: Outlets on introSlideView is nil when it shoudn't be
//            page.titleLabel.text = Intro.introSlides[i].title
//            page.detailLabel.text = Intro.introSlides[i].detail
//            page.slideImageView.image = UIImage(named: Intro.introSlides[i].imageName)
            i += 1
        }

        pageControl.currentPage = 0
    }
}

//MARK: - IBActions
extension IntroductionViewController {
    @IBAction func onPageControlPressed(_ sender: Any) {
        scrollView.scrollToPage(page: pageControl.currentPage)
    }

    @IBAction func onLoginPressed(_ sender: Any) {
        let loginVC: LoginViewController = UIStoryboard(.login).instantiateViewController()
        loginVC.introSender = true
        navigationController?.show(loginVC, sender: self)
    }

    @IBAction func onSkipPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension IntroductionViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let viewWidth: CGFloat = scrollView.frame.width
        let pageNumber = floor((scrollView.contentOffset.x - viewWidth * 0.5) / viewWidth) + 1
        pageControl.currentPage = Int(pageNumber)
    }
}
