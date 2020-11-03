//
//  solo.swift
//  concert
//
//  Created by 慈慈 on 2020/11/2.
//

import SwiftUI

struct test: View{
    var body: some View{
        HStack{
            Image(systemName: "scribble.variable")
            Text("演唱會應援色")
        }
    }
}


let songs=["是你", "喜歡你", "第一次告白", "和你在一起"]
let gifts = ["簽名照一張", "合照一次", "合唱一次", "飛吻一個"]

struct solo: View {
    @State private var scale : CGFloat = 1
    @State private var color = Color(red: 255/255, green: 182/255 ,blue: 193/255)
    @State private var showAlert = false
    @State private var num = 0
    @Binding var husband: Int
    @Binding var name : String
    
    
    var body: some View {
        VStack{
            GeometryReader{ geometry in
                Image(boys[husband])
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.width*3/4)
                    .scaleEffect(scale)
            }
            Form{
                Slider(value: $scale, in: 0.5...1.5, step: 0.05, minimumValueLabel: Image(systemName: "heart.fill").imageScale(.small), maximumValueLabel: Image(systemName: "heart.fill").imageScale(.large)){Text("")}
                    .accentColor(color)
                
                DisclosureGroup( content:{
                    ForEach(songs.indices){(index) in
                        Text(songs[index])
                    }
                },
                label:{
                    HStack{
                        Image(systemName: "music.note").imageScale(.large)
                        Text("演唱會歌單")
                    }
                })
                
                ColorPicker("演唱會應援色", selection: $color)
                
                Button(action:{
                    showAlert = true
                    num = Int.random(in: 0...3)
                }){
                    Text("粉絲福利")
                }.alert(isPresented: $showAlert){
                    ()->Alert in
                        return Alert(title: Text("獲得\(gifts[num])"),
                            message: Text("恭喜\(boys[husband%4])的寶貝\(name)"),
                            dismissButton: .destructive(Text("太幸福了！"), action: {
                            print("")
                         }))
                }
                
            }
        }
    }
}

struct solo_Previews: PreviewProvider {
    static var previews: some View {
        solo(husband: .constant(0), name: .constant("慈慈"))
    }
}
