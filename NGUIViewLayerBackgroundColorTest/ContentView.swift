//
//  ContentView.swift
//  NGUIViewLayerBackgroundColorTest
//
//  Created by Noah Gilmore on 12/26/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import UIKit
import SwiftUI

class ExampleView: UIView {
    private let sublayer = CALayer()
    var providesAction: Bool = false

    init() {
        super.init(frame: .zero)
        self.layer.backgroundColor = UIColor.blue.cgColor

        self.layer.addSublayer(self.sublayer)
        self.sublayer.backgroundColor = UIColor.red.cgColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.sublayer.frame = CGRect(x: 0, y: self.layer.bounds.height / 2, width: self.layer.bounds.width, height: self.layer.bounds.height / 2)
    }

    func setMainViewHighlighted(_ value: Bool) {
        self.backgroundColor = value ? UIColor.red : UIColor.blue
    }

    func setSubViewHighlighted(_ value: Bool) {
        self.sublayer.backgroundColor = value ? UIColor.yellow.cgColor : UIColor.green.cgColor
    }

    override func action(for layer: CALayer, forKey event: String) -> CAAction? {
        if event == "backgroundColor" && providesAction {
            let animation = CABasicAnimation()
            animation.duration = 5
            animation.fromValue = layer.backgroundColor
            return animation
        }
        return super.action(for: layer, forKey: event)
    }
}

struct ExampleViewRepresentable: UIViewRepresentable {
    let mainViewHighlighted: Bool
    let subViewHighlighted: Bool
    let providesAction: Bool

    func makeUIView(context: UIViewRepresentableContext<ExampleViewRepresentable>) -> ExampleView {
        let view = ExampleView()
        view.setMainViewHighlighted(self.mainViewHighlighted)
        view.setSubViewHighlighted(self.subViewHighlighted)
        view.providesAction = providesAction
        return view
    }

    func updateUIView(_ uiView: ExampleView, context: UIViewRepresentableContext<ExampleViewRepresentable>) {
        uiView.setMainViewHighlighted(self.mainViewHighlighted)
        uiView.setSubViewHighlighted(self.subViewHighlighted)
        uiView.providesAction = providesAction
    }
}

struct ContentView: View {
    @State var main: Bool = false
    @State var sub: Bool = false
    @State var providesAction: Bool = false

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            ExampleViewRepresentable(
                mainViewHighlighted: self.main,
                subViewHighlighted: self.sub,
                providesAction: self.providesAction
            )
            VStack {
                HStack {
                    Toggle(isOn: self.$main, label: { Text("Main") })
                    Toggle(isOn: self.$sub, label: { Text("Sub") })
                }
                HStack {
                    Toggle(isOn: self.$providesAction, label: { Text("Return action from action(for:forKey:)") })
                }
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
