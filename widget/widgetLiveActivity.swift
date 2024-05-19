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
    var alarmTime = dateFormat.date(from: "21:00:00")!
    var nowTime = Date.now
    static let dateFormat: DateFormatter = {
         let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
         return formatter
     }()
    static let dateFormatter2 = DateComponentsFormatter()
    var restTime: TimeInterval {
        alarmTime.timeIntervalSince(nowTime)
    }
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: widgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            HStack {
                Image(systemName: "leaf.fill")
                    .foregroundColor(.customGreen)
                Text("\(context.attributes.message)")
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
                }
                DynamicIslandExpandedRegion(.trailing) {
                }
                DynamicIslandExpandedRegion(.bottom) {
                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(context.attributes.message)")
                                Text("\(alarmTime.formatted(date: .omitted, time: .standard))...\(widgetLiveActivity.dateFormatter2.string(from: restTime))")
                                    .font(.title2)
                                    .bold()
                                    .foregroundStyle(.customGreen)
                            }
                            Spacer()
                            Image(systemName: "leaf.fill")
                                .foregroundColor(.customGreen)
                                .font(.largeTitle)
                        }
                        Button("잔디 심으러 가기") {}
                            .frame(maxWidth: .infinity)
                    }
                }
            } compactLeading: {
                Image(systemName: "leaf.fill")
                    .foregroundColor(.customGreen)
            } compactTrailing: {
                Text("\(context.state.time)")
                    .foregroundColor(.customGreen)
            } minimal: {
                Text(context.state.time)
                    .foregroundColor(.customGreen)
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
