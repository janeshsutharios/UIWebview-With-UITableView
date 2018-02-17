import UIKit
class ViewController: UIViewController {
    @IBOutlet var FAQTable: UITableView!
    static let str = """
<!DOCTYPE html>
<html>
<body>

<h2>JavaScript String Properties</h2>

<p>The length property returns the length of a string:</p>

<p id="demo"></p>

<script>
var txt = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
document.getElementById("demo").innerHTML = txt.length;
</script>

</body>
</html>
"""
    var contentHeights : [CGFloat] = [0.0, 0.0]
    var content : [String] = [HTMLObj.htmlString,str]


    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
    }
    func setUpTable() {
        FAQTable.estimatedRowHeight = 100
        FAQTable.rowHeight = UITableViewAutomaticDimension
        FAQTable.register(UINib(nibName: "FAQTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
}
extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! FAQTableViewCell
        cell.FAQWebView.loadHTMLString(HTMLObj.htmlString, baseURL: nil)
        cell.FAQWebView.delegate = self
        cell.FAQWebView.tag = indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if contentHeights[indexPath.row] != 0 {
            return contentHeights[indexPath.row]
        }
        return 300
    }
}
extension ViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print(  "scrollView \(webView.scrollView.contentSize.height)" )
        print(  "sizeThatFits \(webView.sizeThatFits(.zero))" )

        if (contentHeights[webView.tag] != 0.0) {
            return
        }
        print(webView.sizeThatFits(.zero))
        contentHeights[webView.tag] = webView.scrollView.contentSize.height + 10//10 for prevent webview vertical scroll
        FAQTable.reloadRows(at: [IndexPath(row: webView.tag, section: 0)], with: .automatic)


    }
}
