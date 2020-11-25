//
//  CardView.swift
//  Flashzilla
//
//  Created by Andres Vazquez on 2020-10-19.
//

import SwiftUI

struct CardView: View {
    let card: Card
    var shouldReset = false
    var removal: ((_ isCorrect: Bool) -> Void)?
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    @State private var feedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                        ? Color.white
                        : Color.white
                            .opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    differentiateWithoutColor
                        ? nil
                        : RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(getBackgroundColor(withOffset: offset.width))
                )
                .shadow(radius: 10)
            
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
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibility(addTraits: .isButton)
        .gesture(
            DragGesture()
                .onChanged({ gesture in
                    self.offset = gesture.translation
                    self.feedback.prepare()
                })
                .onEnded({ _ in
                    if abs(self.offset.width) > 100 {
                        self.removal?(self.offset.width > 0)
                        
                        if self.offset.width < 0 {
                            self.feedback.notificationOccurred(.error)
                            
                            if shouldReset {
                                self.resetPosition()
                            }
                        }
                    } else {
                        self.resetPosition()
                    }
                })
        )
        .onTapGesture {
            self.isShowingAnswer.toggle()
        }
        .animation(.spring())
    }
    
    func resetPosition() {
        isShowingAnswer = false
        offset = .zero
    }
    
    func getBackgroundColor(withOffset offset: CGFloat) -> Color {
        if offset > 0 {
            return .green
        } else if offset < 0{
            return .red
        }
        return .white
    }
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        
        return self.offset(x: 0, y: offset * 10)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
