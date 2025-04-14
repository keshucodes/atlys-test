//
//  CarouselItemView.swift
//  AtlysCarousel
//
//  Created by Keshu Rai on 15/04/25.
//

import SwiftUI
struct CarouselItemView<Content: View>: View {
    let index: Int
    let activeIndex: Int
    let content: () -> Content
    
    init(index: Int, activeIndex: Int, @ViewBuilder content: @escaping () -> Content) {
        self.index = index
        self.activeIndex = activeIndex
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            content()
                .clipShape(
                    RoundedRectangle(cornerRadius: index == activeIndex ? 20 : 4)
                )
                .frame(width: geometry.size.width * 0.7)
                .scaleEffect(index == activeIndex ? 1.1 : 0.9)
                .offset(x: CGFloat(index - activeIndex) * (geometry.size.width - geometry.size.width * 0.7) / 2)
        }
    }
}
