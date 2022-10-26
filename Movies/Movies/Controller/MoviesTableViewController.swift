// MoviesTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран Фильма
final class MoviesTableViewController: UITableViewController {
    // MARK: - Private Property

    let cellReuseIdendifier = "cell"
    let sessionConfiguration = URLSessionConfiguration.default
    let decoder = JSONDecoder()
    var movies: [Movie] = []
    lazy var session = URLSession.shared

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        obtainPosts()
        setupUI()
        configureUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
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

    func obtainPosts() {
        guard let url =
            URL(
                string: "https://api.themoviedb.org/3/movie/popular?api_key=5e95e9b030369d612dfb2d6ecdfb4cf2&language=ru-RU"
            ) else { return }
        session.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            if let error = error {
                print("Error")
            }

            if let data = data {
                do {
                    self.movies = try JSONDecoder().decode(Results.self, from: data).results
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }

    func configureUI() {
        view.backgroundColor = .systemBackground
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32.0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120.0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32.0).isActive = true

        tableView.register(
            MovieTableViewCell.self,
            forCellReuseIdentifier: cellReuseIdendifier
        )
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        let cell = MovieTableViewCell(style: .default, reuseIdentifier: cellReuseIdendifier)
        cell.updateCell(movie: movie)
        return cell
    }
}
