//
//  widgetLiveActivity.swift
//  widget
//
//  Created by Groo on 5/18/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct widgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var time: String
    }

    // Fixed non-changing properties about your activity go here!
    var message: String
}

struct widgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: widgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            HStack {
                Image(systemName: "leaf.fill")
                    .foregroundColor(.customGreen)
                Text("잔디를 심을 시간이에요!")
                    .foregroundStyle(.white)
                Spacer()
                Text("\(context.state.time)")
                    .font(.title)
                    .foregroundStyle(.green)
            }
            .padding()
            .background(.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.time)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.time)")
            } minimal: {
                Text(context.state.time)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension widgetAttributes {
    fileprivate static var preview: widgetAttributes {
        widgetAttributes(message: "잔디를 심을 시간이에요!")
    }
}

extension widgetAttributes.ContentState {
    fileprivate static var smiley: widgetAttributes.ContentState {
        widgetAttributes.ContentState(time: "+10:00")
     }
     
     fileprivate static var starEyes: widgetAttributes.ContentState {
         widgetAttributes.ContentState(time: "-10:00")
     }
}

#Preview("Notification", as: .content, using: widgetAttributes.preview) {
   widgetLiveActivity()
} contentStates: {
    widgetAttributes.ContentState.smiley
    widgetAttributes.ContentState.starEyes
}
