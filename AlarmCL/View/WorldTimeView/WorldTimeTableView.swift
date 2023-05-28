//
//  WorldTimeTableView.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/28.
//
import SwiftUI
import UIKit

struct WorldTimeTableView: UIViewRepresentable {
    
    var worldtimes: [[WorldTimes]]
    let didSelectRow: (WorldTimes) -> Void
    
    func makeUIView(context: Context) -> UITableView {
        let tableView =  UITableView(frame: .zero, style: .plain)
        tableView.delegate = context.coordinator
        tableView.dataSource  = context.coordinator
        return tableView
    }
    
    func updateUIView(_ uiView: UITableView, context: Context) {
        uiView.reloadData()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(worldtimes: worldtimes, didSelectRow: didSelectRow)
    }
    
    final class Coordinator: NSObject, UITableViewDataSource, UITableViewDelegate {
        
        let worldtimes: [[WorldTimes]]
        let didSelectRow: (WorldTimes) -> Void
        
        init(worldtimes: [[WorldTimes]], didSelectRow: @escaping (WorldTimes) -> Void) {
            self.worldtimes = worldtimes
            self.didSelectRow = didSelectRow
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return worldtimes[section].count
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return worldtimes.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cellId = "cellIdentifier"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId) ?? UITableViewCell(style: .default, reuseIdentifier: cellId)
            
            cell.textLabel?.text = "\(worldtimes[indexPath.section][indexPath.row].city)"
            return cell
        }
        
        func sectionIndexTitles(for tableView: UITableView) -> [String]? {
            
            let titles:[String] = worldtimes.map { String(($0.first?.city.prefix(1))!)}
            return titles
        }
//        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//            let label = UILabel()
//            label.text = String(worldtimes[section][0].city.prefix(1))
//            return label
//
//        }
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = .systemBackground
            
            let titleLabel = UILabel()
            titleLabel.text = String(worldtimes[section][0].city.prefix(1))
            titleLabel.textColor = .white
            titleLabel.font = .boldSystemFont(ofSize: 17)
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview(titleLabel)
            
            // Add constraints to position the titleLabel within the headerView
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
            ])
            
            return headerView
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let item = worldtimes[indexPath.section][indexPath.row]
            didSelectRow(item)
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            let sectionHeaderHeight: CGFloat = 30.0 // Modify this value as needed
            return sectionHeaderHeight
        }
        
    }
}
