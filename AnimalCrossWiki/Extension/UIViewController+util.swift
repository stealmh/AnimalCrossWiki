//
//  Extension+UIViewController.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/03/14.
//

import UIKit
import SwiftUI

#if DEBUG
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
            let viewController: UIViewController

            func makeUIViewController(context: Context) -> UIViewController {
                return viewController
            }

            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            }
        }

    func toPreview() -> some View {
            Preview(viewController: self)
    }
    
    func isScrolledToBottom(_ myPosition: CGPoint, _ tableView: UITableView) -> Bool {
        if myPosition.y > tableView.contentSize.height - 100 - tableView.bounds.size.height {
            return true
        }
        return false
    }
}
#endif


