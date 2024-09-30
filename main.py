from dataclasses import dataclass
from typing import Optional 
@dataclass 
class Node:
    data : int
    next : Optional['Node'] = None 

class LinkedList:
    def __init__ (self):
        self.head : Optional[Node] = None 
    def pop(self):
        if not self.head:
            return 
        if not self.head.next:
            return
        current = self.head 
        while current.next and current.next.next:
            current = current.next 
        current.next = None 
    def len(self):
        if not self.head:
            return 0
        if not self.head.next:
            return 1 
        current = self.head 
        length = 1 
        while current.next:
            length = length + 1 
            current = current.next 
        return length 
    def push(self,data):
        new_node = Node(data)
        if not self.head:
            self.head = new_node 
        else:
            current = self.head 
            while current.next:
                current = current.next 
            current.next = new_node
    def get_index(self,data):
        current = self.head 
        index = 0 
        while current:
            if current.data == data:
                return index 
            current= current.next 
            index +=1 
        return -1 
    def delete_at_index(self,index):
        if index >= self.len() or index < 0:
            raise KeyError("Index out of bounds") 
        current = self.head 
        curr_index = 0
        prev = None 
        if index == 0:
            self.head = current.next
            return 
        while current:
            if curr_index == index:
                prev.next = current.next 
                return 
            prev = current 
            curr_index = curr_index + 1 
            current = current.next 
    def insert_at_index(self,data,index):
        if index >= self.len() or index < 0 :
            raise KeyError("Index out of bounds") 

        current = self.head 
        new_node = Node(data)
        curr_index = 0 
        if index == 0:
            new_node.next = current
            self.head = new_node 
            return 
        while current:
            if curr_index == index - 1:
                new_node.next = current.next 
                current.next = new_node 
                return 
            curr_index = curr_index + 1
            current = current.next 
    def clear(self):
        self.head = None 
    def print_ll(self):
        current = self.head
        while current:
            print(current.data,end="->")
            current = current.next 
        print("None") 

linked_list = LinkedList()

# Test push method
linked_list.push(1)
linked_list.push(2)
linked_list.push(3)
linked_list.push(4)
assert linked_list.len() == 4, "Length should be 4 after pushing 4 elements"
assert linked_list.get_index(1) == 0, "Index of 1 should be 0"
assert linked_list.get_index(2) == 1, "Index of 2 should be 1"
assert linked_list.get_index(3) == 2, "Index of 3 should be 2"
assert linked_list.get_index(4) == 3, "Index of 4 should be 3"

# Test delete_at_index method
linked_list.delete_at_index(3)
assert linked_list.len() == 3, "Length should be 3 after deleting 1 element"
assert linked_list.get_index(4) == -1, "Index of 4 should be -1 after deletion"

# Test insert_at_index method
linked_list.insert_at_index(5, 1)
assert linked_list.len() == 4, "Length should be 4 after inserting 1 element"
assert linked_list.get_index(5) == 1, "Index of 5 should be 1 after insertion"

# Test pop method
linked_list.pop()
assert linked_list.len() == 3, "Length should be 3 after popping 1 element"
assert linked_list.get_index(3) == -1, "Index of 3 should be -1 after popping"

# Test clear method
linked_list.clear()
assert linked_list.len() == 0, "Length should be 0 after clearing the list"
assert linked_list.head is None, "Head should be None after clearing the list"

# Test print_ll method (visual check)
linked_list.push(1)
linked_list.push(2)
linked_list.push(3)
linked_list.print_ll()  # Output: 1->2->3->None

print("All assertions passed.")
