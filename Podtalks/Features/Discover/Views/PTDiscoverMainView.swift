//
//  PTDiscoverMainView.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 28/10/23.
//

import UIKit

class PTDiscoverMainView: UIView, DiscoverViewmodelDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        let viewmodel = DiscoverViewmodel()
        viewmodel.delegate = self
//        viewmodel.load()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not loaded by: PTDiscoverMainView")
    }
    
    func updateUI(for model: [DiscoverUISection]) {
//        print(model.)
    }
    
    func showError(with message: String?) {
        print(message)
    }
}
