//
//  ContentView.swift
//  Shared
//
//  Created by Brackelope on 9/10/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = ViewModel()
   
    var body: some View {
        ZStack {
//            Image("momir-bg")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
            
            VStack {
                Spacer()
                HStack {
                    Button("-") {
                        viewModel.decCount()
                    }
                    
                    Button(viewModel.buttonTitle) {
                        viewModel.submit()
                    }
                    
                    Button("+") {
                        viewModel.incCount()
                    }
                }
                .background(Color.white)
                
                ScrollViewReader { scrollview in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.cards) { card in
                                Image(uiImage: card.image!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(10.0)
                                    .animation(.easeIn)
                                    .id(card.id)
                                    .onAppear {
                                        withAnimation {
                                            scrollview.scrollTo(card.id, anchor: .center)
                                        }
                                    }
                                    
                            }
                        }
                    }
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 100, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                
            }
        }
        .background(Image("momir-bg").resizable()
                        .aspectRatio(contentMode: .fill))
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
