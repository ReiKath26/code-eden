//
//  ReadGlossary.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 23/07/22.
//

import SwiftUI
import AVFoundation

struct ReadGlossary: View {
    
    @State var isPlaying = false
    @ObservedObject var readGlossary: presentMode
    
    var thisGlossary: glossary?
    
    let synth = AVSpeechSynthesizer()
    
    var body: some View {
        ZStack
        {
            Image("iPhone Background").resizable().scaledToFill().edgesIgnoringSafeArea(.all)
            
            GeometryReader
            {
                geo in
                
                ZStack
                {
                    RoundedRectangle(cornerRadius: 10).frame(width: geo.size.width * 0.9, height: geo.size.height * 0.8).foregroundColor(Color("whiteAccent"))
                    
                    VStack
                    {
                        Image(thisGlossary?.cover ?? "Intro Cover").resizable().frame(width: geo.size.width * 0.8, height: geo.size.height * 0.1)
                        
                        Text(thisGlossary?.title ?? "Loading title...").font(Font.custom("Silom", size: geo.size.width * 0.07)).foregroundColor(Color("mainPurple"))
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            Text(thisGlossary?.material ?? "Loading material...").font(Font.custom("Silom", size: geo.size.width * 0.03)).foregroundColor(Color("mainPurple"))
                        }.frame(width: geo.size.width * 0.8, height: geo.size.height * 0.5)
                        
                        
                        HStack(spacing: 200)
                        {
                            Button {
                                withAnimation {
                                    readGlossary.isShown.toggle()
                                }
                            } label: {
                                Image(systemName: "arrowshape.turn.up.backward.fill").font(.system(size: 24)).foregroundColor(Color("mainPurple"))
                            }
                            
                            Button {
                                
                                if isPlaying
                                {
                                    synth.pauseSpeaking(at: .immediate)
                                    isPlaying.toggle()
                                }
                                
                                else
                                {
                                    isPlaying.toggle()
                                    let utterance = AVSpeechUtterance(string: thisGlossary?.material ?? "Loading material")
                                    utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                                    
                                    if !synth.isPaused
                                    {
                                        synth.speak(utterance)
                                    }
                                    
                                    else
                                    {
                                        synth.continueSpeaking()
                                    }
                                }
                                
                            } label: {
                                Image(systemName: isPlaying ? "pause.fill" : "headphones").font(.system(size: 24)).foregroundColor(Color("mainPurple"))
                            }
                            
                            

                        }
                    }
                    
                  
                    
                    
                }.position(x: geo.size.width/2, y: geo.size.height/2)
            }
        }
    }
}

struct ReadGlossary_Previews: PreviewProvider {
    static var previews: some View {
        ReadGlossary(readGlossary: presentMode())
    }
}
