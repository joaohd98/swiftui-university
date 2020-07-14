//
//  SlideHorizontal.swift
//  Sims School
//
//  Created by João Damazio on 14/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import UIKit
import Combine

struct SlideHorizontal: UIViewControllerRepresentable {
    var controllers: [UIViewController]
    @Binding var currentPage: Int

	func makeUIViewController(context: Context) -> UIPageViewController {
		let optionsDict = [UIPageViewController.OptionsKey.interPageSpacing : 20]

		let pageViewController = UIPageViewController(
			  transitionStyle: .scroll,
			  navigationOrientation: .horizontal,
			  options: optionsDict
		)

		pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator

		return pageViewController
	}
	
	func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
		pageViewController.setViewControllers(
			[controllers[currentPage]],
			direction: .forward,
			animated: true
		)
   }
	
	
	func makeCoordinator() -> Coordinator {
		  Coordinator(self)
	}

    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: SlideHorizontal

        init(_ pageViewController: SlideHorizontal) {
            self.parent = pageViewController
        }

        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerBefore viewController: UIViewController) -> UIViewController?
        {
            guard let index = parent.controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index == 0 {
                return parent.controllers.last
            }
            return parent.controllers[index - 1]
        }

        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerAfter viewController: UIViewController) -> UIViewController?
        {
            guard let index = parent.controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index + 1 == parent.controllers.count {
                return parent.controllers.first
            }
            return parent.controllers[index + 1]
        }
		
		func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
			  if completed,
				  let visibleViewController = pageViewController.viewControllers?.first,
				  let index = parent.controllers.firstIndex(of: visibleViewController)
			  {
				  parent.currentPage = index
			  }
		}
	
    }
	
}

struct SlideHorizontal_Previews: PreviewProvider {
	@State static var currentPage: Int = 0
	
    static var previews: some View {
        SlideHorizontal(controllers: [], currentPage: $currentPage)
    }
}