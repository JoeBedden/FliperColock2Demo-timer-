//
//  ContentView.swift
//  FliperColock2
//
//  Created by 雷子康 on 2023/7/13.
//

import SwiftUI


//定义
struct NumberView: View {
    var number: Int
    @State private var rotation = 0.0
    
    var body: some View {
        Text("\(number)")
            .font(.system(size: 150, weight: .bold, design: .rounded))
            //.rotationEffect(.degrees(rotation))
            //.animation(.easeInOut(duration: 0.5))
            .id(number)
            .onChange(of: number) { _ in
                withAnimation {
                    rotation += 90
                }
            }
    }
}

struct ContentView: View {
    @State var hour: Int = 0
    @State var minute: Int = 0
    @State var second: Int = 0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.black
            
            HStack {
                NumberView(number: hour)
                Text(":").font(.system(size: 150, weight: .bold, design: .rounded))
                NumberView(number: minute)
                Text(":").font(.system(size: 150, weight: .bold, design: .rounded))
                NumberView(number: second)
            }
            .foregroundColor(.white)
            
        }
        .onReceive(timer) { _ in
            let calendar = Calendar.current
            let components = calendar.dateComponents([.hour, .minute, .second], from: Date())
            hour = components.hour ?? 0
            minute = components.minute ?? 0
            second = components.second ?? 0
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
