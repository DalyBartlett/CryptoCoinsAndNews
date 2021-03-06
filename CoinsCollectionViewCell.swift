//
//  CoinsCollectionViewCell.swift
//  Crypto Headlines
//
//  Created by Joshua Geronimo on 2/18/18.
//  Copyright © 2018 Joshua Geronimo. All rights reserved.
//

import UIKit

class CoinsCollectionViewCell: UICollectionViewCell {
    
    fileprivate let cryptoInfoContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            view.backgroundColor = UIColor(named:"primary_light")!
        } else {
            // Fallback on earlier versions
        }
        view.layer.cornerRadius = 25
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.5
        return view
    }()
    
    fileprivate let cryptoNameAndRankLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()
    
    fileprivate let cryptoPriceAndPercentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setUpLayout()
    }
    
    // Will update the cell's data
    @available(iOS 11.0, *)
    func updateCoinFeed(with coinsFrom: CoinMarketCap)
    {
        // RANK & SYMBOL
        let nameAndrankAttributedText = NSMutableAttributedString(string: "#\(coinsFrom.rank)", attributes: [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16, weight: .light),
            NSAttributedStringKey.foregroundColor : UIColor(named:"accent_light")!])
        nameAndrankAttributedText.append(NSAttributedString(string: "\n\(coinsFrom.symbol)", attributes: [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 36, weight: .medium),
            NSAttributedStringKey.foregroundColor : UIColor(named:"primary_text")!]))
        cryptoNameAndRankLabel.attributedText = nameAndrankAttributedText
        
        // PRICE OF COIN
        let priceAndPercentAttributedText = NSMutableAttributedString(string: "\(convertToCurrency(coinsFrom.price_usd))", attributes:[
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 34, weight: .light),
            NSAttributedStringKey.foregroundColor : UIColor(named:"primary_text")!])
        priceAndPercentAttributedText.append(NSAttributedString(string: "\n Past Day ", attributes: [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17, weight: .light),
            NSAttributedStringKey.foregroundColor : UIColor(named:"accent_light")!]))
        let percentChange = Double(coinsFrom.percent_change_24h)!
        // load the percent change of the coin
        if percentChange >= 0 {
            // change the percent to green if the value is positive
            priceAndPercentAttributedText.append(NSAttributedString(string: "(\(coinsFrom.percent_change_24h)%)", attributes: [
                NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17, weight: .light),
                NSAttributedStringKey.foregroundColor : UIColor(named:"positive")!]))
        } else {
            // change the percent to red if the value is negative
            priceAndPercentAttributedText.append(NSAttributedString(string: "(\(coinsFrom.percent_change_24h)%)", attributes: [
                NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17, weight: .light),
                NSAttributedStringKey.foregroundColor : UIColor(named:"negative")!]))
        }
        cryptoPriceAndPercentLabel.attributedText = priceAndPercentAttributedText
    }
    
    fileprivate func setUpLayout() {
        addSubview(cryptoInfoContainer)
        cryptoInfoContainer.addSubview(cryptoNameAndRankLabel)
        cryptoInfoContainer.addSubview(cryptoPriceAndPercentLabel)
        
        NSLayoutConstraint.activate([
            // constraints for cryptoInfoContainer
            cryptoInfoContainer.topAnchor.constraint(equalTo: topAnchor),
            cryptoInfoContainer.heightAnchor.constraint(equalTo: heightAnchor),
            cryptoInfoContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            cryptoInfoContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            // constraints for cryptoNameAndRankLabel
            cryptoNameAndRankLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            cryptoNameAndRankLabel.widthAnchor.constraint(equalToConstant: frame.width / 3.5),
            cryptoNameAndRankLabel.leadingAnchor.constraint(equalTo: cryptoInfoContainer.leadingAnchor, constant: 14),
            // constraints for cryptoPriceAndPercentLabel
            cryptoPriceAndPercentLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            cryptoPriceAndPercentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: frame.width / 2.2),
            cryptoPriceAndPercentLabel.trailingAnchor.constraint(equalTo: cryptoInfoContainer.trailingAnchor, constant: -12)])
    }
    
    // This function will convert a number into currency format
    fileprivate func convertToCurrency(_ number: String) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = NumberFormatter.Style.currency
        let numberDouble = Double(number)!
        if numberDouble >= 1000 {
            //numberString = convertToCurrency(number: numberDouble)
            let priceOfCoin: NSNumber = numberDouble as NSNumber
            let priceString = currencyFormatter.string(from: priceOfCoin)!
            return priceString
        }
        return "$\(number)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
