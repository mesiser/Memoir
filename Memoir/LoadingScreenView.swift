//
//  LoadingScreenView.swift
//  Memoir
//
//  Created by Vadim Shalugin on 30/01/25.
//

import CoreData
import SwiftUI

struct LoadingScreenView: View {
    
    @State private var isActive = false
    @State private var animationAmount = 0.0
    private var context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    var body: some View {
        let memoirListView = MemoirListView(context: context)
        NavigationView {
            VStack {
                if self.isActive {
                    memoirListView
                } else {
                    ZStack {
                        VStack(spacing: 0) {
                            Rectangle()
                                .fill(.white)
                                .frame(height: 300)
                            HStack {
                                Rectangle()
                                    .fill(.white)
                                    .frame(width: animationAmount, height: 100)
                                Image("pigeon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding(.leading, 90)
                            }
                        }
                        VStack(spacing: 0) {
                            Image("statue")
                                .resizable()
//                                .background(Color("BrownColor"))
                                .scaledToFit()
                                .frame(width: 500, height:300)
                            ZStack {
                                Rectangle()
                                    .fill(.white)
                                    .frame(width: 200, height: 100)
                                    .border(.black, width: 1)
                                    .cornerRadius(10)
                                Text("Memento Mori")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                    .bold()
                                    .italic()
//                                ProgressView()
//                                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
//                                    .scaleEffect(1.2, anchor: .center)
//                                    .foregroundColor(.white)
                            }
                        }


                    }
                }
            }.onAppear {
                showPigeon()
                hidePigeon()
                gotoLoginScreen()
            }

        }
    }
    
    func showPigeon() {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(1.0)) {
            withAnimation(.linear(duration: 0.8)) {
                animationAmount = 80
            }
        }
    }
    
    func hidePigeon() {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(2.3)) {
            withAnimation(.linear(duration: 0.8)) {
                animationAmount = 0
            }
        }
    }
    
    func gotoLoginScreen() {
         DispatchQueue.main.asyncAfter(deadline: .now() + Double(3.6)) {
             self.isActive = true
         }
    }
}

struct LoadingScreenView_Previews: PreviewProvider {
    static var dataController = DataController()

    static var previews: some View {
        let viewContext = dataController.container.viewContext
        LoadingScreenView(context: viewContext)
    }
}
