//
//  TimeLabel.swift
//  Med Buddy
//
//  Created by Grant Sivley on 3/28/21.
//

import UIKit

class TimeLabel: UILabel {
    
    private struct Const {
        /// Image height/width for Large NavBar state
        static let ImageSizeForLargeState: CGFloat = 40
        /// Margin from right anchor of safe area to right anchor of Image
        static let ImageRightMargin: CGFloat = 16
        /// Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
        static let ImageBottomMarginForLargeState: CGFloat = 12
        /// Margin from bottom anchor of NavBar to bottom anchor of Image for Small NavBar state
        static let ImageBottomMarginForSmallState: CGFloat = 12
        /// Image height/width for Small NavBar state
        static let ImageSizeForSmallState: CGFloat = 22
        /// Height of NavBar for Small state. Usually it's just 44
        static let NavBarHeightSmallState: CGFloat = 44
        /// Height of NavBar for Large state. Usually it's just 96.5 but if you have a custom font for the title, please make sure to edit this value since it changes the height for Large state of NavBar
        static let NavBarHeightLargeState: CGFloat = 96.5
        
        static let NavBarFontLargeState: CGFloat = 36
        static let NavBarFontSmallState: CGFloat = 16
        
    }
    
    func setupTimeLabel(on navBar: UINavigationBar) {
        frame = CGRect(x: 0, y: 0, width: 130, height: 43)
        
        backgroundColor = .clear
        
        textColor = UIColor(named: K.colors.drugDarkBlue)
        
        font = UIFont(name: "Quicksand-Regular", size: Const.NavBarFontLargeState)
        attributedText = NSMutableAttributedString(string: "3:33 PM", attributes: [NSAttributedString.Key.kern: -1.8])
        // Initial setup for image for Large NavBar state since the the screen always has Large NavBar once it gets opened
        navBar.addSubview(self)
        
        // setup constraints
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightAnchor.constraint(equalTo: navBar.rightAnchor, constant: -Const.ImageRightMargin),
            bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -Const.ImageBottomMarginForLargeState),
            heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
            
            //view.widthAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
   
    func moveAndResizeLabel(for height: CGFloat) {
        let coeff: CGFloat = {
            let delta = height - Const.NavBarHeightSmallState
            let heightDifferenceBetweenStates = (Const.NavBarHeightLargeState - Const.NavBarHeightSmallState)
            return delta / heightDifferenceBetweenStates
        }()

        let factor = Const.ImageSizeForSmallState / Const.ImageSizeForLargeState

        let scale: CGFloat = {
            let sizeAddendumFactor = coeff * (1.0 - factor)
            return min(1.0, sizeAddendumFactor + factor)
        }()

        // Value of difference between icons for large and small states
        let sizeDiff = Const.ImageSizeForLargeState * (1.0 - factor) // 8.0
        let yTranslation: CGFloat = {
            /// This value = 14. It equals to difference of 12 and 6 (bottom margin for large and small states). Also it adds 8.0 (size difference when the image gets smaller size)
            let maxYTranslation = Const.ImageBottomMarginForLargeState - Const.ImageBottomMarginForSmallState + sizeDiff
            return max(0, min(maxYTranslation, (maxYTranslation - coeff * (Const.ImageBottomMarginForSmallState + sizeDiff))))
        }()

        let xTranslation = max(0, sizeDiff - coeff * sizeDiff)

        self.transform = CGAffineTransform.identity
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: xTranslation, y: yTranslation)
    }
}
