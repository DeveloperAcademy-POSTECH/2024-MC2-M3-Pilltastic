//
//  LottieView.swift
//  MC2-Team3-Pilling
//
//  Created by ram on 5/27/24.
//
import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    var animationFileName: String
    let loopMode: LottieLoopMode
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear  // 배경을 투명하게 설정
        let animationView = LottieAnimationView(name: animationFileName)
        animationView.loopMode = loopMode
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.contentMode = .scaleAspectFit
        animationView.backgroundColor = .clear  // Lottie 애니메이션 뷰의 배경을 투명하게 설정
        animationView.play { (finished) in
            if finished {
                DispatchQueue.main.async {
                    animationView.isHidden = true
                }
            }
        }
        view.addSubview(animationView)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}




#Preview {
    LottieView(animationFileName: "ButtonLottie", loopMode: .loop)
        .frame(width: 100,height: 100)
}
