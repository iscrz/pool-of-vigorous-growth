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
            GeometryReader { geo in
                
                Image("momir-bg")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                    .clipped()
                
            }
            
            VStack {
                Spacer()
                
                HStack {
                    
                    Button(action: {
                        viewModel.decCount()
                    }, label: {
                        Image(systemName: "minus.circle")
                            .foregroundColor(.white)
                            .shadow(color: .purple, radius: 20, x: 10.0, y:10.0)
                    })
                    
                    
                    Button(action: {
                        viewModel.submit()
                    }, label: {
                        Image(viewModel.buttonTitle)
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                            .background(Color.clear)
                            .shadow(color: .black, radius: 10.0, x: -10.0, y:10.0)
                    })
                    .padding()
                    
                    Button(action: {
                        viewModel.incCount()
                    }, label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(.white)
                            .shadow(color: .purple, radius: 20, x: 10.0, y:10.0)
                    })
                }
                .padding()
                
                
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
            .padding(.bottom, 50)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
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
                    //.shadow(color: .black, radius: 10.0, x: -10.0, y:10.0)
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
                    .shadow(color: .black.opacity(0.3), radius: 10.0, x: -20.0, y:20.0)
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
