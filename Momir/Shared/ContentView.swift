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
                        HStack(alignment: .center, spacing: 5.0) {
                            ForEach(viewModel.cardRequests) { request in
                                CardView(state: CardState(request))
                                    .id(request.id)
                                    .onAppear {
                                        withAnimation {
                                            scrollview.scrollTo(request.id, anchor: .center)
                                        }
                                    }
                                }
                                .frame(width: 250 * (63/88))
                            
                            Spacer(minLength: 10.0 + (250 * (63/88) * 0.5))
                            }
                        }
                    }
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 100, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
        }
        .background(Image("momir-bg").resizable()
                        .aspectRatio(contentMode: .fill))
    }
}

struct CardView: View {
    
    @StateObject var state: CardState
    @State var opacity = 0.0
    
    @State private var rotating = false

    
    var body: some View {
        return VStack {
            
            
            
            if state.image != nil {
                Image(uiImage: state.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10.0)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation {
                            opacity = 1.0
                        }
                    }
            } else {
                
                Image("Simic_Logo2")
                    .rotationEffect(Angle(degrees: rotating ? 360 : 0))
                    .animation(Animation.linear(duration: 2.0).repeatForever(autoreverses: false), value: rotating)
                    .transition(.opacity)
                    .onAppear {
                        self.rotating = true
                    }
                
            }
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
