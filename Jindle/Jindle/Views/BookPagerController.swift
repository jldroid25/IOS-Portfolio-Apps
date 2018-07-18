//
//  BookPageController.swift
//  Jindle
//
//  Created by JL on 5/7/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

 //Custom UItableView for all the book pages
class BookPagerController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        navigationItem.title = self.book?.title
        
        //register PageCell view cell
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        
        /*Accessing the layout parameter for the view
        Which dictates how cells to be layed.
        Needed For view pager to scroll horizontally
         */
       let layout = collectionView?.collectionViewLayout as?
        UICollectionViewFlowLayout
        layout?.scrollDirection = .horizontal
        
        //Set the line Spacing between pages to 0,
        //reduce the default spacing gap
        layout?.minimumLineSpacing = 0
        
        /* let the paging snap to the edge of the screen
        instead of default linear scroll to give the
         scrolling a more page swipe feel or look.
        */
        collectionView?.isPagingEnabled = true
        
        /*
         Navbar close button, to close pager & return to home page
         */
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(handleCloseBook))
    }
    
    //Declare handleCloseBook to close itself or dismiss the entire controller
    @objc func handleCloseBook(){
        dismiss(animated: true, completion: nil)
    }
    
    /*Set the sizes of the each pager to match the view size
     protocol to help specify the size of an item
    We had to inherit from UICollectionViewDelegateFlowLayout
    */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 44 - 20)
    }
    
    //Render the pagers
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //get the exact page or return zero
        //Another safe way to unwrap an optional ?? some value
        return book?.pages.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        //"as!" downCast to access PageCell view components
        
        //Access the page'sbook for each book
        //and their respective's texts
        let page = book?.pages[indexPath.item]
        pageCell.textLabel.text = page?.text
        
        
        /*
        //Let's alternate the BgColor for each cell
        //based on index value being odd or even index
        if indexPath.item % 2 == 0 {
            cell.backgroundColor = .red
        } else{
            cell.backgroundColor = .blue

        }
 */
        
        return pageCell
    }
}


