//
//  CustomProgressStyle.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 23/07/22.
//

import SwiftUI

struct CustomProgressStyle<Stroke: ShapeStyle, Background: ShapeStyle> : ProgressViewStyle
{

            var stroke: Stroke
            var fill: Background
            var caption: String = ""
            var cornerRadius: CGFloat = 10
            var width: CGFloat = 600
            var height: CGFloat = 20
            var animation: Animation = .easeInOut
            
            func makeBody(configuration: Configuration) -> some View {
                let fractionCompleted = configuration.fractionCompleted ?? 0
                
                return VStack {
                    ZStack(alignment: .topLeading) {
                        GeometryReader { geo in
                            Rectangle()
                                .fill(fill)
                                .frame(maxWidth: geo.size.width * CGFloat(fractionCompleted))
                                .animation(animation)
                        }
                    }
                    .frame(width: width, height: height)
                    .cornerRadius(cornerRadius)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                                .stroke(stroke, lineWidth: 2)
                    )
                    
                    if !caption.isEmpty {
                        Text("\(caption)")
                            .font(.caption)
                    }
                }
        
            }
    
}
