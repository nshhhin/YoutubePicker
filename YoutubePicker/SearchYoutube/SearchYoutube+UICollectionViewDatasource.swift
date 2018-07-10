

import UIKit
import AlamofireImage

extension SearchYoutubeVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        if let results = self.results {
            return (results.results?.count)!
        } else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(with: SearchResultCell.self,
                                                       for: indexPath)
        let result = results.results![indexPath.row]
        let strImg = result.thumbnail
        print(strImg)
        cell.titleLbale.text = result.title
        if let url = URL(string: result.thumbnail) {
            cell.thumbnailView.af_setImage(withURL: url)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destinationVC = R.storyboard.playYoutube.instantiateInitialViewController()
        destinationVC!.result = results.results![indexPath.row]
        present(destinationVC!, animated: true, completion: nil)
    }
    
}
