//
//  AutoScroller.swift
//  CitizenshipCivics
//
//  Created by Uttarkar, Kiran on 2/2/24.
//

import SwiftUI

struct AutoScroller: View {
    var questions = Questions()
    let timer = Timer.publish(every: 15, on: .main, in: .common).autoconnect()
    @State private var fadeOut = false
    @State private var studyMode = true
    @State private var isHidden = true
    @State private var recallMode = true
    @State private var scale = 0.00
    let starIcon = Image(systemName: "star.circle")
    let previous = Image(systemName: "arrowshape.backward.fill")
    let forward = Image(systemName: "arrowshape.forward.fill")
    @State var questionNumber = ""
    
    
    @State private var selectedTextIndex: Int = 0
    
    var body: some View {
        ZStack(alignment: .center) {
            
            TabView(selection: $selectedTextIndex) {
                ForEach(questions.testQuestions) { question in
                    VStack {
                        if (recallMode) {
                            Text("\(question.id). \(question.question)")
                                .padding(6)
                                .background(Capsule().fill(.gray.opacity(0.3)))
                                .padding(35)
                                .frame(maxWidth: 550)
                                .fixedSize()
                                .font(.system(size: 20))
                                .italic()
                                .bold()
                                .multilineTextAlignment(.center)
                                .foregroundColor(.darkBlue)
                                .lineLimit(nil)
                            Spacer()
                                .frame(height: 45)
                            Text("\(starIcon) \(question.answer)")
                                .padding(6)
                                .background(Capsule().fill(.gray.opacity(0.4)))
                                .frame(maxWidth: 450)
                                .fixedSize()
                                .font(.system(size: 18))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.darkBlue)
                                .bold()
                                .lineLimit(nil)
                                .opacity(isHidden ? 0 : 1)
                            Spacer()
                                .frame(height:45)
                            Button(action: {
                                isHidden.toggle()
                            }, label: {
                                isHidden ?
                                Label("Show Answer", systemImage: "eye.circle.fill")
                                    .font(.system(size: 12))
                                    .bold()
                                    .foregroundStyle(.darkBlue)
                                :
                                Label("Hide Answer", systemImage:
                                        "eye.slash.circle.fill")
                                .font(.system(size: 12))
                                .bold()
                                .foregroundStyle(.darkBlue)
                            })
                            .controlSize(.mini)
                        } else {
                            Text("\(question.id). \(question.question)")
                                .padding(6)
                                .background(Capsule().fill(.gray.opacity(0.3)))
                                .padding(35)
                                .frame(maxWidth: 550)
                                .fixedSize()
                                .font(.system(size: 20))
                                .italic()
                                .bold()
                                .multilineTextAlignment(.center)
                                .foregroundColor(.darkBlue)
                                .lineLimit(nil)
                            Spacer()
                                .frame(height: 25)
                            Text("\(starIcon) \(question.answer)")
                                .padding(6)
                                .background(Capsule().fill(.gray.opacity(0.4)))
                                .frame(maxWidth: 450)
                                .fixedSize()
                                .font(.system(size: 18))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.darkBlue)
                                .bold()
                                .lineLimit(nil)
                                .opacity(1)
                            Spacer()
                                .frame(height: 60)
                        }
                    }
                }
                
            }
            .frame(height: 300)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea()
            
            // previous button
            HStack {
                VStack{
                    Button("\(previous)"){
                        selectedTextIndex = (selectedTextIndex - 1) % questions.testQuestions.count
                        if recallMode{
                            if isHidden == false {
                                isHidden = true
                            }
                        }
                    }
                    .frame(width: 80, height: 80, alignment: .center)
                    .foregroundColor(.darkBlue)
                    Spacer().frame(height: 60)
                }
                Spacer().frame(width: 500)
                VStack {
                    //forward button
                    Button("\(forward)"){
                        selectedTextIndex = (selectedTextIndex + 1) % questions.testQuestions.count
                        if recallMode{
                            if isHidden == false {
                                isHidden = true
                            }
                        }
                    }
                    .frame(width: 80, height: 80, alignment: .center)
                    .foregroundStyle(.darkBlue)
                    //switch mode button
                    Button(action: {
                        recallMode.toggle()
                    }, label: {
                        recallMode ?
                        Label("Recall Mode", systemImage: "brain.fill")
                            .font(.system(size: 10))
                            .bold()
                            .foregroundStyle(.darkRed)
                        :
                        Label("Study Mode", systemImage:
                                "book.fill")
                        .font(.system(size: 10))
                        .bold()
                        .foregroundStyle(.darkRed)
                    })
                    .overlay(
                        Capsule()
                            .stroke(.darkRed, lineWidth: 1)
                            .frame(width: 100, height: 30, alignment: .center)
                        )
                }
                
            }
        }
        .onReceive(timer) { _ in
            withAnimation(.default) {
                selectedTextIndex = (selectedTextIndex + 1) % questions.testQuestions.count
                if recallMode{
                    if isHidden == false {
                        isHidden = true
                    } else if !recallMode {
                        isHidden = false
                    }
                }
            }
        }
        //Go to question number section
        HStack(alignment: .center){
            TextField("Go to question number: ", text: $questionNumber)
                .keyboardType(.numberPad)
                .keyboardShortcut(.defaultAction)
                .textFieldStyle(.roundedBorder)
                .frame(width: 250)
                .foregroundColor(.white)
                .onSubmit {
                    if let myNumber = NumberFormatter().number(from: questionNumber) {
                        let myInt = myNumber.intValue
                        if 0...100 ~= myInt {
                            selectedTextIndex = myInt
                        }
                    } else {
                        return
                    }
                }
            Button(action: {
                if let myNumber = NumberFormatter().number(from: questionNumber) {
                    let myInt = myNumber.intValue
                    if 0...100 ~= myInt {
                        selectedTextIndex = myInt
                    }
                } else {
                    return
                }
            }, label: {
                Image(systemName: "magnifyingglass.circle.fill")
                    .frame(width: 40, height: 40, alignment: .center)
                    .foregroundColor(.darkRed)
                    .clipShape(Circle())
            })
            .keyboardShortcut(.defaultAction)
        }
    }
}

#Preview {
    AutoScroller()
}
