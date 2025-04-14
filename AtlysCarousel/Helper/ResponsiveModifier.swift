//
//  ResponsiveModifier.swift
//  AtlysCarousel
//
//  Created by Keshu Rai on 15/04/25.
//

import SwiftUI

struct ResponsiveModifier: ViewModifier {
    
    let height : Float
    func body(content: Content) -> some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            content // No height constraint on iPad
        } else {
            content.frame(height : CGFloat(height)) // Apply height only for iPhone
        }
    }
}

extension View {
    func responsiveHeight(height : Float) -> some View {
        self.modifier(ResponsiveModifier(height : height))
    }
}
