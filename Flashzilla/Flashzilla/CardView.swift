//
//  CardView.swift
//  Flashzilla
//
//  Created by Japneet Singh on /189/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct CardView: View {
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    @State private var feedback = UINotificationFeedbackGenerator()
    
    @Binding var sendToBack: Bool
    
    let card: Card
    var sendToBackFunc: (()->Void)? = nil
    var removal: (() -> Void)? = nil
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    func colorOffset(offset: CGFloat)->Color{
        switch(offset){
            case let a where a>0 :
                return Color.green
        case let b where b<0:
            return Color.red
        default:
            return Color.white
        }
            
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                        ? Color.white :
                    Color.white.opacity(1 - Double(abs(offset.width / 50)))
                )
                .shadow(radius: 10)
                .background(
                    differentiateWithoutColor ? nil :
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(self.colorOffset(offset: offset.width))
            )

            VStack {
                if accessibilityEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)

                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width*5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
            .accessibility(addTraits: .isButton)
        .gesture(
                DragGesture()
                    .onChanged { gesture in
                        self.offset = gesture.translation
                        self.feedback.prepare()
                    }

                    .onEnded { _ in
                        if abs(self.offset.width) > 100 {
                            
                            if self.offset.width > 0{
                                
                                self.feedback.notificationOccurred(.success)
                                 self.removal?()
                                
                            }
                            
                            if self.offset.width<0 {
                                
                                self.feedback.notificationOccurred(.error)
                                
                                if self.sendToBack {
                                    self.sendToBackFunc?()
                                }
                                
                                self.removal?()
                                
                            }
                            
                        } else {
                            self.offset = .zero
                        }
                    }
            )
        .onTapGesture {
            self.isShowingAnswer.toggle()
        }
        .animation(.spring())
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(sendToBack: .constant(true), card: Card.example)
    }
}
