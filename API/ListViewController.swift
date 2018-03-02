
import UIKit

class ListViewController : UITableViewController, XMLParserDelegate {
    
    var parser:XMLParser!
    var items = [Item]()
    var item:Item?
    var currentString = ""
    
//    行数指定
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
//    値を表示
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }
//    繰り返し処理
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startDownload()
    }
//    データの取得
    func startDownload() {
        self.items = []
        if let url = URL(
            string: "http://www.apple.com/jp/pr/feeds/pr.rss"){
            if let parser = XMLParser(contentsOf: url) {
                self.parser = parser
                self.parser.delegate = self
                self.parser.parse()
            }
            }
    }
//    アイテムを見つける処理
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        self.currentString = ""
        if elementName == "item" {
            self.item = Item()
        }
    }
//    データの追加
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        self.currentString += string
    }
//    データの分析
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch elementName {
        case "title": self.item?.title = currentString
        case "link": self.item?.link = currentString
        case "item": self.items.append(self.item!)
        default : break
        }
    }
//    テーブルビューの更新
    func parserDidEndDocument(_ parser: XMLParser) {
        self.tableView.reloadData()
    }
//    segueで値、画面の移動
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let item = items[indexPath.row]
            let controller = segue.destination as! DetailViewController
            controller.title = item.title
            controller.link = item.link
        }
    }
}
