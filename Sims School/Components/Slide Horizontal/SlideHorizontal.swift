/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view for bridging a UIPageViewController.
*/

import SwiftUI

struct SlideHorizontal<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]
	var hasDots: Bool
	var isInModal: Bool
		
	@State var currentPage: Int
	@State var isSliding = false
	
	var currentPageCallBack: (Int) -> Void
	var isSlidingCallBack: (Bool) -> Void
	
	init(
		_ views: [Page],
		hasDots: Bool,
		currentPage: Int = 0,
		currentPageCallBack: @escaping (Int) -> Void = { _ in },
		isSlidingCallBack: @escaping (Bool) -> Void = { _ in },
		isInModal: Bool = false) {
		
		self.viewControllers = views.map { UIHostingController(rootView: $0) }
		self.hasDots = hasDots
		self.isInModal = isInModal
		self.currentPageCallBack = currentPageCallBack
		self.isSlidingCallBack = isSlidingCallBack
		self._currentPage = State(initialValue: currentPage)
	}

    var body: some View {
		VStack(alignment: .center, spacing: 0) {
			CustomUIPageViewController(
				controllers: viewControllers,
				currentPage: $currentPage,
				isInModal: isInModal,
				currentPageCallBack: currentPageCallBack,
				isSlidingCallBack: isSlidingCallBack
			)
			if self.hasDots {
				SlideHorizontalDots(numberOfPages: viewControllers.count, currentPage: $currentPage)
			}
        }
    }
}

 
