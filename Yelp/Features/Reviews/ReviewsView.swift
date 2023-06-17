//
//  ReviewsView.swift
//  Yelp
//
//  Created by JonathanTriC on 17/06/23.
//

import SwiftUI

struct ReviewsView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = ReviewsViewModel()
    @State var businessId: String
    @State var offset: Int = 0
    
    var body: some View {
        ZStack {
            Color("BgColor")
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Reviews")
                        .font(.title.bold())
                    
                    Spacer()
                    
                    Button("Close") {
                        dismiss()
                    }
                }
                .padding(.bottom)
                
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.gray))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                } else {
                    
                    ScrollView(showsIndicators: false) {
                        ForEach(viewModel.model.reviews) { review in
                            ReviewsCard(imageUrl: review.user.imageURL ?? "",
                                        name: review.user.name,
                                        date: review.timeCreated,
                                        rating: review.rating,
                                        text: review.text)
                        }
                    }
                }
                
            }
            .padding()
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .task {
            await viewModel.fetchData(businessId: businessId, offset: offset)
        }
    }
}

struct ReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsView(businessId: "zj8Lq1T8KIC5zwFief15jg")
    }
}
