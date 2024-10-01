data Node = Node { dataValue :: Int, next :: Maybe Node } deriving (Show)

data LinkedList = LinkedList { headNode :: Maybe Node } deriving (Show)

emptyList :: LinkedList
emptyList = LinkedList Nothing

push :: Int -> LinkedList -> LinkedList
push value (LinkedList Nothing) = LinkedList (Just (Node value Nothing))
push value (LinkedList (Just head)) = LinkedList (Just (pushHelper value head))
  where
    pushHelper val (Node d Nothing) = Node d (Just (Node val Nothing))
    pushHelper val (Node d (Just nextNode)) = Node d (Just (pushHelper val nextNode))

insertAtIndex :: Int -> Int -> LinkedList -> LinkedList
insertAtIndex value 0 (LinkedList Nothing) = LinkedList (Just (Node value Nothing))
insertAtIndex value 0 (LinkedList (Just head)) = LinkedList (Just (Node value (Just head)))
insertAtIndex value index (LinkedList Nothing) = error "Index out of bounds"
insertAtIndex value index (LinkedList (Just head)) = LinkedList (Just (insertHelper value index head))
  where
    insertHelper val 0 (Node d nextNode) = Node d (Just (Node val nextNode))
    insertHelper val idx (Node d Nothing) = error "Index out of bounds"
    insertHelper val idx (Node d (Just nextNode)) = Node d (Just (insertHelper val (idx - 1) nextNode))

pop :: LinkedList -> LinkedList
pop (LinkedList Nothing) = LinkedList Nothing
pop (LinkedList (Just head)) = LinkedList (popHelper head)
  where
    popHelper (Node _ Nothing) = Nothing
    popHelper (Node d (Just nextNode)) = Just (Node d (popHelper' nextNode))
    popHelper' (Node _ Nothing) = Nothing
    popHelper' (Node d (Just nextNode)) = Just (Node d (popHelper' nextNode))

deleteAtIndex :: Int -> LinkedList -> LinkedList
deleteAtIndex _ (LinkedList Nothing) = error "Index out of bounds"
deleteAtIndex 0 (LinkedList (Just (Node _ nextNode))) = LinkedList nextNode
deleteAtIndex index (LinkedList (Just head)) = LinkedList (Just (deleteHelper index head))
  where
    deleteHelper 0 (Node _ nextNode) = nextNode
    deleteHelper idx (Node d Nothing) = error "Index out of bounds"
    deleteHelper idx (Node d (Just nextNode)) = Just (Node d (deleteHelper (idx - 1) nextNode))

len :: LinkedList -> Int
len (LinkedList Nothing) = 0
len (LinkedList (Just head)) = lenHelper head
  where
    lenHelper (Node _ Nothing) = 1
    lenHelper (Node _ (Just nextNode)) = 1 + lenHelper nextNode

printList :: LinkedList -> IO ()
printList (LinkedList Nothing) = putStrLn "Empty list"
printList (LinkedList (Just head)) = printHelper head
  where
    printHelper (Node d Nothing) = print d
    printHelper (Node d (Just nextNode)) = do
      print d
      printHelper nextNode

main :: IO ()
main = do
  let list1 = emptyList
  let list2 = push 1 list1
  let list3 = push 2 list2
  let list4 = insertAtIndex 3 1 list3
  putStrLn "List after push and insert operations:"
  printList list4
  let list5 = pop list4
  putStrLn "List after pop operation:"
  printList list5
  let list6 = deleteAtIndex 1 list5
  putStrLn "List after delete at index 1 operation:"
  printList list6
  putStrLn $ "Length of the list: " ++ show (len list6)
