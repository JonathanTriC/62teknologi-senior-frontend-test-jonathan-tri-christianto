//
//  ReviewsCard.swift
//  Yelp
//
//  Created by JonathanTriC on 17/06/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ReviewsCard: View {
    var imageUrl: String
    var name: String
    var date: String
    var rating: Double
    var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                WebImage(url: URL(string: imageUrl))
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(name)
                        .fontWeight(.medium)
                    
                    Text(convertDateFormat(date))
                        .font(.footnote)
                }
            }
            
            StarsView(rating: Float(rating))
            
            Text(text)
            
            Divider()
        }

    }
}

struct ReviewsCard_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsCard(imageUrl: "https://s3-media2.fl.yelpcdn.com/photo/vHvvlGbaugMCvneIPv4f7w/o.jpg",
                    name: "Shaylja S.",
                    date: "2023-06-09 19:15:21",
                    rating: 5,
                    text: "Hands down one of the best places for detroit style pizza in NYC. I will come here multiple times when I am visiting NYC for the spicy vodka slice. I am...")
    }
}
