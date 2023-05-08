//
//  ContentView.swift
//  PieCharts
//
//  Created by Vitaliy Iakushev on 07.05.2023.
//

import SwiftUI



struct ContentView: View {
    
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "line.horizontal.3")
                            .resizable()
                            .frame(width: 20, height: 11)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "bell.fill")
                            .foregroundColor(.black)
                    }
                }
                Text("My Portfolio")
                    .bold()
            }
            .padding([.leading, .trailing])
            Divider()
                .padding([.leading, .trailing], -15)
            
            // Pie Chart
            GeometryReader { geometry in
                
                ZStack {
                    ForEach(0..<data.count) {i in
                        DrawShape(center: CGPoint(x: geometry.frame(in: .global).width / 2, y: geometry.frame(in: .global).height / 2), index: i)
                    }
                    
                    Circle()
                        .fill(Color.white)
                        .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.5)
                    
                }
            }
            
            .frame(height: 360)
            .padding()
            .clipShape(Circle())
            .shadow(radius: 8)
            
            VStack {
                ForEach(data) { i in
                    HStack(alignment: .center) {
                        Rectangle()
                            .fill(i.color)
                            .frame(width: 20, height: 20)
                        Text(i.name)
                            .frame(width: 150, alignment: .leading)
//                        Spacer()
                        
                        Spacer()
                            Text(String(format: "\(i.percent)", "%.f") + "%")
                                .bold()
                                .padding(.leading, 10)
//                            Spacer()
                        
                        
                    }
                    .padding(.top)
                }
            }
            .padding()
            
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
        .padding()
    }
}

//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Home()
//    }
//}

struct DrawShape : View {
    var center: CGPoint
    var index: Int
    
    var body: some View {
        
        Path { path in
            
            path.move(to: self.center)
            path.addArc(center: self.center, radius: 170, startAngle: .init(degrees: from()), endAngle: .init(degrees: to()), clockwise: false)
            
        }
        .fill(data[index].color)
    }
    
    func from() -> Double {
        if index == 0 {
            return 0
        } else {
            var temp : Double = 0
            for i in 0...index-1 {
                temp += Double(data[i].percent / 100) * 360
            }
            return temp
        }
    }
     
    func to() -> Double {
        var temp : Double = 0
        for i in 0...index {
            temp += Double(data[i].percent / 100) * 360
        }
        return temp
    }
    
}



struct Pie : Identifiable {
    var id: Int
    var percent: CGFloat
    var name: String
    var color: Color
}

var data = [
    Pie(id: 0, percent: 35, name: "Large Cap Equity", color: Color("Color1")),
    Pie(id: 1, percent: 10, name: "Small Cap Equity", color: Color("Color2")),
    Pie(id: 2, percent: 15, name: "International Equity", color: Color("Color3")),
    Pie(id: 3, percent: 35, name: "Fixed Income", color: Color("Color4")),
    Pie(id: 4, percent: 5, name: "Cash Investments", color: Color("Color"))
]
