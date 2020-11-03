//
//  ContentView.swift
//  concert
//
//  Created by 慈慈 on 2020/11/2.
//

import SwiftUI

let boys=["TFBOYS", "王俊凱", "王源", "易烊千璽", "tf", "karry", "rong", "jackson"]

struct ContentView: View {
    @State private var islove = false
    @State private var time = Date()
    @State private var ticket = 0
    @State private var husband = 0
    @State private var name = ""
    @State private var show = false
    @State private var much = false
    @State var temp = ""
    
    var year : Int{
        return Calendar.current.component(.year, from: time)
    }
    
    var body: some View {
        VStack{
            GeometryReader{ geometry in
                Image("test")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height:
                            geometry.size.width)
            }
            
                Form{
                    Toggle("你是真粉絲嗎?", isOn: $islove)
                    DatePicker("演唱會", selection: $time, in: DateComponents(calendar: Calendar.current, year:2013, month:8, day:6).date!...Date(), displayedComponents: .date)
                    Stepper("買了\(ticket)張票", value: $ticket)
                    
                    TextField("你是誰？", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    VStack(alignment: .leading){
                        Text("你的老公是...?")
                        Picker(selection: $husband, label: Image(systemName: "heart.fill")){
                            ForEach(0..<4){ (index) in
                                    Text(boys[index])
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    
                        Button(action:{
                            show = true
                            if islove{
                                husband += 4
                            }
                        }){
                            HStack{
                                Text("老公我來了")
                                Image(systemName: "heart.fill")
                            }
                        }.sheet(isPresented: $show){
                            solo(husband: $husband, name: $name)
                        }
                        
                        Button(action:{
                            much = true
                            temp = "\(year)"
                        }){
                            HStack{
                                Text("時光倒流")
                                Image(systemName: "paperplane.fill")
                            }
                        }.alert(isPresented: $much){
                            ()->Alert in
                            return Alert(title: Text("\(temp)年的演唱會"),
                                    message: Text("有\(ticket)份回憶"),
                                    dismissButton: .default(Text("八週年見！"), action: {
                                    print("")
                                 }))
                        }
                    
                }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
