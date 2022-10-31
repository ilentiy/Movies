// HeaderImageTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с постером
class HeaderImageTableViewCell: UITableViewCell {
    // MARK: - Pivate Visual Component

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 0.75
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()

    private let backdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        backdropImageViewConstraints()
        posterImageViewConstraints()
    }

    private func backdropImageViewConstraints() {
        NSLayoutConstraint.activate([
            backdropImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backdropImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            backdropImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backdropImageView.widthAnchor.constraint(equalTo: widthAnchor),
            backdropImageView.heightAnchor.constraint(equalTo: backdropImageView.widthAnchor, multiplier: 0.56),
        ])
    }

    private func posterImageViewConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor, constant: 25),
            posterImageView.centerYAnchor.constraint(equalTo: backdropImageView.centerYAnchor),
            posterImageView.heightAnchor.constraint(equalTo: backdropImageView.heightAnchor, multiplier: 0.75),
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 0.66),
        ])
    }
}
