// MovieTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Прототип ячейки типа списка фильма
final class MovieTableViewCell: UITableViewCell {
    // MARK: - Pivate Visual Component

    private let posterImageView: UIImageView = {
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
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        voteAverageLable.translatesAutoresizingMaskIntoConstraints = false
        setupUI()
        setupConstraints()
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
            voteAverageLable.backgroundColor = .red
        case 5 ..< 7:
            voteAverageLable.backgroundColor = .orange
        case 7 ... 10:
            voteAverageLable.backgroundColor = .systemGreen
        default:
            voteAverageLable.backgroundColor = .clear
        }
        voteAverageLable.text = String(format: "%.1f", movie.voteAverage)
    }

    // MARK: - Private Methods

    private func setupUI() {
        addSubview(posterImageView)
        addSubview(overviewLabel)
        addSubview(titleLabel)
        addSubview(voteAverageLable)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 0.75),
            posterImageView.heightAnchor.constraint(equalToConstant: 200),

            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 35),

            voteAverageLable.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            voteAverageLable.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            voteAverageLable.widthAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 0.2),
            voteAverageLable.heightAnchor.constraint(equalTo: voteAverageLable.widthAnchor),

            overviewLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10),
            overviewLabel.topAnchor.constraint(equalTo: voteAverageLable.bottomAnchor, constant: 5),
            overviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            overviewLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
        ])
    }
}
