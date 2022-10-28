// HeaderImageTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с постером
class HeaderImageTableViewCell: UITableViewCell {
    // MARK: - Pivate Visual Component

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 0.75
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()

    private let backdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()

    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 13)
        return label
    }()

    private let voteAverageLable: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1.5
        label.layer.borderColor = UIColor.yellow.cgColor
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .heavy)
        label.textColor = .label
        label.clipsToBounds = true
        label.backgroundColor = .orange
        return label
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        backdropImageView.translatesAutoresizingMaskIntoConstraints = false
        setupUI()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    func updateCell(movie: MovieDetail) {
        guard let posterURL = URL(string: BaseURL.image + movie.posterPath),
              let backdropPathURL = URL(string: BaseURL.image + movie.backdropPath)
        else { return }
        posterImageView.load(url: posterURL)
        backdropImageView.load(url: backdropPathURL)
    }

    // MARK: - Private Methods

    private func setupUI() {
        addSubview(backdropImageView)
        addSubview(posterImageView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backdropImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backdropImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            backdropImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backdropImageView.widthAnchor.constraint(equalTo: widthAnchor),
            backdropImageView.heightAnchor.constraint(equalTo: backdropImageView.widthAnchor, multiplier: 0.56),

            posterImageView.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor, constant: 25),
            posterImageView.centerYAnchor.constraint(equalTo: backdropImageView.centerYAnchor),
            posterImageView.heightAnchor.constraint(equalTo: backdropImageView.heightAnchor, multiplier: 0.75),
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 0.66),
        ])
    }
}
