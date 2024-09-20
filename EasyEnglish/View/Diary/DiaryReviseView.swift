//
//  DiaryReviseView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/18/24.
//

import SwiftUI

struct DiaryReviseView: View {
    var body: some View {
        
        ScrollView {
            VStack {
                
                Text("Friday, 13 March 2018")
                    .frame(maxWidth: .infinity, alignment: .leading)
    //                .padding(.bottom, 2)
                
                Text("Full-day Hike in the Moun")
                    .font(.title.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<6) { item in
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: Constants.screenWidth - 50, height: 240)
                        }
                    }
                }
                .padding(.vertical)
                
                Text("The city of southern califonia, san diego is locally known as America's firest city Presenting a language learning UI design concept here. It’s mainly for second/third generation immigrants to learn their mother tongue from family members, rather than dictionary-based systematic learning. What do you think? Let me know in the comment 👇Any constructive criticism is welcome! Visit my portfolio for more works: michellezhudesign.com Welcome to connect via instagram: https://www.instagram.com/michelle.ux.ui Got an idea? Thinking about building a language app or flashcard app? Reach out and let's talk!")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            
        }
        .padding(25)
        .navigationTitle("Diary")
        .navigationBarTitleDisplayMode(.inline)
        
        Button(action: {
            print("revise")
        }, label: {
            Image(systemName: "pencil")
                .resizable()
                .frame(width: 20, height: 20)
        })
        
    }
}

#Preview {
    DiaryReviseView()
}
