// MovieTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран Фильма
final class MovieTableViewController: UITableViewController {
    // MARK: - Constants

    private enum TableCellTypes {
        case header
        case description
    }

    // MARK: - Private Property

    private let tableCellTypes: [TableCellTypes] = [.header, .description]

    let sessionConfiguration = URLSessionConfiguration.default
    let decoder = JSONDecoder()
    var movieID: Int?
    var movieDetail: MovieDetail?
    lazy var session = URLSession.shared

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        obtainMovie(id: movieID ?? 0)
        setupUI()
        configureUI()
    }

    // MARK: - Public Methods

    func obtainMovie(id: Int) {
        guard let url =
            URL(
                string: BaseURL.movies + "\(id)" + BaseURL.apiKey
            ) else { return }
        session.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            if let error = error {
                print(error)
            }

            if let data = data {
                do {
                    self.movieDetail = try JSONDecoder().decode(MovieDetail.self, from: data)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }

    // MARK: - Private Methods

    private func setupUI() {
        tableView.allowsSelection = false
        refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    }

    @objc private func refreshAction() {
        tableView.refreshControl?.beginRefreshing()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        tableView.refreshControl?.endRefreshing()
    }

    private func configureUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .label
        tableView.register(
            HeaderImageTableViewCell.self,
            forCellReuseIdentifier: Identifiers.headerImage
        )
        tableView.register(
            MainInfoTableViewCell.self,
            forCellReuseIdentifier: Identifiers.mainInfo
        )
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        tableCellTypes.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movie = movieDetail else { return UITableViewCell() }
        let type = tableCellTypes[indexPath.section]
        switch type {
        case .header:
            let cell = HeaderImageTableViewCell(style: .default, reuseIdentifier: Identifiers.headerImage)
            cell.updateCell(movie: movie)
            return cell
        case .description:
            let cell = MainInfoTableViewCell(style: .default, reuseIdentifier: Identifiers.mainInfo)
            cell.updateCell(movie: movie)
            return cell
        }
    }
}
