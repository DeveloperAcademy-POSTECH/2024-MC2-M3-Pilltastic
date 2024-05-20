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
    static let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy_HH:mm:ss"
        return formatter
    }()
    static let timeIntervalFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        return formatter
    }()
    @State private var nowTime = Date.now
    @State private var alarmTime = dateFormatter.date(from: "\(Date.now.formatted(date: .numeric, time: .omitted))_23:00:00")!
    var restTime: String {
        let tempTime = nowTime.timeIntervalSince(alarmTime)
        if tempTime > 0 {
            return "+\(widgetLiveActivity.timeIntervalFormatter.string(from: tempTime)!)"
        } else if tempTime < 0 {
            return "\(widgetLiveActivity.timeIntervalFormatter.string(from: tempTime)!)"
        } else {
            return "00:00"
        }
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
                DynamicIslandExpandedRegion(.center) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(restTime)
                                .font(.title2)
                                .bold()
                                .foregroundStyle(.customGreen)
                            Text("\(context.attributes.message)")
                        }
                        Image(systemName: "alarm")
                                .scaledToFill()
                                .foregroundColor(.customGreen)
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
                }
                DynamicIslandExpandedRegion(.bottom) {
                        Button("잔디 심으러 가기") {}
                            .frame(maxWidth: .infinity)
                }
            } compactLeading: {
                Image(systemName: "leaf.fill")
                    .foregroundColor(.customGreen)
            } compactTrailing: {
                Text("\(context.state.time)")
                    .foregroundColor(.customGreen)
            } minimal: {
                Image(systemName: "leaf.fill")
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
