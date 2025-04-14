//
//  HomeView.swift
//  AtlysCarousel
//
//  Created by Keshu Rai on 15/04/25.
//

import SwiftUI

struct CardDataModel: Identifiable {
    let id = UUID()
    let imageName: String
    let label: String
    
}

struct HomeView: View {
    @State private var cards: [CardDataModel] = [
        .init(imageName :"1", label: "Malaysia"),
        .init(imageName :"2", label: "Bangkok"),
        .init(imageName :"3", label: "Pataya"),
        .init(imageName :"4", label: "London")
    ]
    
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        VStack {
            VStack {
                CarouselStackView(currentIndex: $selectedIndex, items: cards) { index, item in
                    ZStack {
                        Image(item.imageName)
                            .resizable()
                            .overlay {
                                Rectangle()
                                    .foregroundStyle(Color.black.opacity(0.4))
                            }
                        
                        Text(item.label)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .aspectRatio(1.0, contentMode: .fit)
                
                    
                    
                }
                .responsiveHeight(height: 250)
                .padding(.vertical,20)
                .onAppear {
                    if(cards.count > 1) {
                        selectedIndex = cards.count / 2 - 1
                    }
                }
                HStack(spacing: 8) {
                    ForEach(0..<cards.count, id: \.self) { index in
                        Circle()
                            .fill(index == selectedIndex ? Color.primary : Color.secondary.opacity(0.5))
                            .frame(width: 10, height: 10)
                    }
                }
                
            }
            Spacer()
            Text("Made with ❤️ for Atlys")
        }
        
    }
}



#Preview {
    HomeView()
}
