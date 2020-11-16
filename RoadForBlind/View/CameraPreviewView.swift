//
//  CameraPreviewView.swift
//  RoadForBlind
//
//  Created by Денис Андриевский on 16.11.2020.
//

import UIKit

enum SignState {
    case attention
    case none
}

final class CameraPreviewView: UIView {

    // MARK: - IBOutlets
    @IBOutlet weak var cameraPreviewView: UIView!
    @IBOutlet private weak var colorSign: UIView!
    // MARK: - Properties
    private var signState: SignState = .none {
        didSet {
            updateUI()
        }
    }
    
    func updateState(_ newState: SignState) {
        signState = newState
    }
    
    func updateUI() {
        switch signState {
        case .attention:
            colorSign.backgroundColor = Color.appAttentionSignRedColor
        case .none:
            colorSign.backgroundColor = Color.appWhiteColor
        }
    }
    
    // MARK: - IBActions
    @IBAction func settingsBtnPressed(_ sender: UIButton) {
        // Settings screen
    }

}
