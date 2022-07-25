//
//  TextToSpeech.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 25/07/22.
//

import AVFoundation

func listenToMaterial(string: String)
{
    let utterance = AVSpeechUtterance(string: string)
    utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

    let synthetizer = AVSpeechSynthesizer()
    
    if synthetizer.isSpeaking
    {
        synthetizer.pauseSpeaking(at: .immediate)
    }
    
    else if synthetizer.isPaused
    {
        synthetizer.continueSpeaking()
    }
    
}
