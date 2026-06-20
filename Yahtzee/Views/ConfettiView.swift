//
//  ConfettiView.swift
//  Rollzee
//
//  Created by Coding Assistant on 6/19/26.
//

import SwiftUI
import UIKit

struct ConfettiView: UIViewRepresentable {
    func makeUIView(context: Context) -> ConfettiEmitterView {
        ConfettiEmitterView()
    }

    func updateUIView(_ uiView: ConfettiEmitterView, context: Context) {}
}

final class ConfettiEmitterView: UIView {
    private let emitterLayer = CAEmitterLayer()
    private var hasStartedBurst = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false
        backgroundColor = .clear
        layer.addSublayer(emitterLayer)
        configureEmitter()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        emitterLayer.frame = bounds
        emitterLayer.emitterPosition = CGPoint(x: bounds.midX, y: -12)
        emitterLayer.emitterSize = CGSize(width: bounds.width, height: 1)

        guard window != nil, bounds.width > 0, !hasStartedBurst else {
            return
        }

        startBurst()
    }

    private func configureEmitter() {
        emitterLayer.emitterShape = .line
        emitterLayer.emitterMode = .surface
        emitterLayer.renderMode = .oldestLast
        emitterLayer.birthRate = 0
        emitterLayer.emitterCells = ConfettiColor.allCases.map { color in
            makeEmitterCell(color: color)
        }
    }

    private func startBurst() {
        hasStartedBurst = true
        emitterLayer.birthRate = 1
        emitterLayer.beginTime = CACurrentMediaTime() - 0.7

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.emitterLayer.birthRate = 0
        }
    }

    private func makeEmitterCell(color: ConfettiColor) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contents = color.image.cgImage
        cell.birthRate = 10
        cell.lifetime = 5.5
        cell.lifetimeRange = 0.4
        cell.velocity = 95
        cell.velocityRange = 28
        cell.yAcceleration = 230
        cell.xAcceleration = 0
        cell.spin = 2.4
        cell.spinRange = 3.5
        cell.scale = 0.65
        cell.scaleRange = 0.18
        return cell
    }
}

private enum ConfettiColor: CaseIterable {
    case red
    case orange
    case yellow
    case green
    case blue
    case purple
    case pink

    var uiColor: UIColor {
        switch self {
        case .red:
            return UIColor(red: 0.92, green: 0.42, blue: 0.42, alpha: 1)
        case .orange:
            return UIColor(red: 0.95, green: 0.62, blue: 0.34, alpha: 1)
        case .yellow:
            return UIColor(red: 0.95, green: 0.82, blue: 0.36, alpha: 1)
        case .green:
            return UIColor(red: 0.38, green: 0.76, blue: 0.52, alpha: 1)
        case .blue:
            return UIColor(red: 0.38, green: 0.64, blue: 0.88, alpha: 1)
        case .purple:
            return UIColor(red: 0.68, green: 0.52, blue: 0.86, alpha: 1)
        case .pink:
            return UIColor(red: 0.92, green: 0.52, blue: 0.70, alpha: 1)
        }
    }

    var image: UIImage {
        let width = Int.random(in: 2...5)
        let heightDelta = Int.random(in: 0...4)
        let size = CGSize(width: width, height: width + heightDelta)
        return UIGraphicsImageRenderer(size: size).image { context in
            uiColor.setFill()
            UIBezierPath(rect: CGRect(origin: .zero, size: size)).fill()
        }
    }
}

#Preview {
    ConfettiView()
}
