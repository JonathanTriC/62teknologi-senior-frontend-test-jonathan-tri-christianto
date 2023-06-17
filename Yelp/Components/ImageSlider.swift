//
//  ImageSlider.swift
//  Yelp
//
//  Created by JonathanTriC on 17/06/23.
//

import SwiftUI
import SDWebImageSwiftUI


public struct ImageSlider: View {
    @State private var selection = 0
    public let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    let images:[String]
    
    public init(_ images:[String]){
        self.images = images
    }
    
    public var body: some View {
        VStack{
            TabView(selection : $selection){
                ForEach(0..<images.count){ i in
                    WebImage(url: URL(string : images[i]))
                        .resizable()
                        .frame(width: .infinity, height: 300)
                        .ignoresSafeArea(.container, edges: .top)
                }
            }
            .frame(height: 300)
            .tabViewStyle(PageTabViewStyle())
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .onReceive(timer, perform: { _ in
                
                withAnimation{
                    selection = selection < images.count ? selection + 1 : 0
                }
            })
        }
    }
}
