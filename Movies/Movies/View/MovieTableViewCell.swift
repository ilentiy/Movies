// MovieTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Прототип ячейки типа списка фильма
final class MovieTableViewCell: UITableViewCell {
    // MARK: - Pivate Visual Component

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()

    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 13)
        return label
    }()

    private let voteAverageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 15
        label.layer.borderColor = UIColor.yellow.cgColor
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .heavy)
        label.textColor = .label
        label.clipsToBounds = true
        label.backgroundColor = .red
        return label
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    func updateCell(movie: Movie) {
        guard let url = URL(string: BaseURL.image + movie.posterPath) else { return }
        posterImageView.load(url: url)
        titleLabel.text = "\(movie.title)"
        overviewLabel.text = movie.overview
        switch movie.voteAverage {
        case 0 ..< 5:
            voteAverageLabel.backgroundColor = .red
        case 5 ..< 7:
            voteAverageLabel.backgroundColor = .orange
        case 7 ... 10:
            voteAverageLabel.backgroundColor = .systemGreen
        default:
            voteAverageLabel.backgroundColor = .clear
        }
        voteAverageLabel.text = String(format: "%.1f", movie.voteAverage)
    }

    // MARK: - Private Methods

    private func setupUI() {
        addSubview(posterImageView)
        addSubview(overviewLabel)
        addSubview(titleLabel)
        addSubview(voteAverageLabel)
        posterImageViewConstraints()
        overviewLabelConstraints()
        titleLabelConstraints()
        voteAverageLabelConstraints()
    }

    private func posterImageViewConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 0.75),
            posterImageView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }

    private func titleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 35),
        ])
    }

    private func voteAverageLabelConstraints() {
        NSLayoutConstraint.activate([
            voteAverageLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            voteAverageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            voteAverageLabel.widthAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 0.2),
            voteAverageLabel.heightAnchor.constraint(equalTo: voteAverageLabel.widthAnchor),
        ])
    }

    private func overviewLabelConstraints() {
        NSLayoutConstraint.activate([
            overviewLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10),
            overviewLabel.topAnchor.constraint(equalTo: voteAverageLabel.bottomAnchor, constant: 5),
            overviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            overviewLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
        ])
    }
}
