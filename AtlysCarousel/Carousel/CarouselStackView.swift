//
//  CarouselStackView.swift
//  AtlysCarousel
//
//  Created by Keshu Rai on 15/04/25.
//

import SwiftUI

struct CarouselStackView<Item: Identifiable, Content: View>: View {
    @Binding var currentIndex: Int
    let items: [Item]
    let contentBuilder: (Int, Item) -> Content
    
    @State private var dragOffset: CGFloat = 0
    @State private var isDragging = false
    @State private var activeIndex: Int = 0

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(Array(items.enumerated()), id: \.element.id) { i, item in
                    CarouselItemView(index: i, activeIndex: activeIndex) {
                        contentBuilder(i, item)
                    }
                    .frame(height: geometry.size.height)
                    .offset(x: CGFloat(i - activeIndex) * geometry.size.width * 0.4)
                    .offset(x: (i == activeIndex || i < activeIndex) ? dragOffset * 0.3 : 0)
                    .zIndex(i == activeIndex ? 2 : 1)
                    .onTapGesture {
                        if i != activeIndex {
                            currentIndex = i
                        }
                    }
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        isDragging = true
                        withAnimation(.spring()) {
                            dragOffset = value.translation.width
                        }
                    }
                    .onEnded { value in
                        withAnimation(.spring()) {
                            dragOffset = 0
                        }
                        isDragging = false
                        let threshold = geometry.size.width * 0.3
                        if value.translation.width < -threshold {
                            currentIndex = min(activeIndex + 1, items.count - 1)
                        } else if value.translation.width > threshold {
                            currentIndex = max(activeIndex - 1, 0)
                        }
                    }
            )
        }
        .onChange(of: currentIndex) {
            withAnimation(.spring()) {
                activeIndex = currentIndex
            }
        }
        .padding(.horizontal)
        .offset(x: UIScreen.main.bounds.width / 8)
    }
}

