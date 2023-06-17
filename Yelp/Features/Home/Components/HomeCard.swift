//
//  HomeCard.swift
//  Yelp
//
//  Created by JonathanTriC on 16/06/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeCard: View {
    var imageUrl: String
    var name: String
    var address: String
    var rating: Double
    var reviewsCount: Int
    
    var body: some View {
        HStack (alignment: .center) {
            WebImage(url: URL(string: imageUrl))
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 130)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.trailing, 8)
            
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                
                Text(address)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                
                StarsView(rating: Float(rating))
                
                Text("\(reviewsCount) Reviews")
                    .font(.subheadline)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background {
            Color.white
        }
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.10),
                radius: 10,
                x: 0,
                y: 3
        )
        .padding(.bottom)
    }
}

struct HomeCard_Previews: PreviewProvider {
    static var previews: some View {
        HomeCard(imageUrl: "https://s3-media2.fl.yelpcdn.com/bphoto/mx112hxMlB1S8zl9GI9dBg/o.jpg",
                 name: "Shuka",
                 address: "38 MacDougal St, New York, NY 10012",
                 rating: 4.5,
                 reviewsCount: 910)
    }
}
