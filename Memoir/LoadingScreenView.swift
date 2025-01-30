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
                        HStack {
                            Rectangle()
                                .fill(.white)
                                .frame(width: animationAmount, height: 100)
                            Image("Pigeon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding(.leading, 20)
                        }
                        ZStack {
                            Rectangle()
                                .fill(.white)
                                .frame(width: 100, height: 100)
                                .border(Color("AccentColor"), width: 5)
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(1.2, anchor: .center)
                            .foregroundColor(Color("AccentColor"))
                        }


                    }
                }
            }.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(1.0)) {
                    withAnimation(.linear(duration: 0.5)) {
                        animationAmount = 50
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(2.0)) {
                    withAnimation(.linear(duration: 0.5)) {
                        animationAmount = 0
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(3.0)) {
                    self.gotoLoginScreen()
                }
            }

        }
    }
    
    func gotoLoginScreen() {
        self.isActive = true
    }
}

struct LoadingScreenView_Previews: PreviewProvider {
    static var dataController = DataController()

    static var previews: some View {
        let viewContext = dataController.container.viewContext
        LoadingScreenView(context: viewContext)
    }
}
